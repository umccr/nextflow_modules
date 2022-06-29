process PURPLE_GERMLINE {
  //conda (params.enable_conda ? "bioconda::hmftools-purple=3.4" : null)
  container 'docker.io/scwatts/purple:3.4'

  input:
  tuple val(meta), path(amber), path(cobalt), path(smlv_normal_vcf)
  path(ref_data_genome_dir)
  val(ref_data_genome_fn)
  path(gc_profile)
  path(known_hotspots_GERMLINE)
  path(driver_gene_panel)
  path(ensembl_data_dir)

  output:
  tuple val(meta), path('purple/'), emit: purple_dir
  path 'versions.yml'             , emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  """
  # For provided smlv VCFs, filter records that do not contain the required FORMAT/AD field and
  # get argument for PURPLE
  get_smlv_arg() {
    fp=\${1}
    fn=\${fp##*/}
    fp_out="prepared__\${2}__\${fn}"
    bcftools filter -Oz -e 'FORMAT/AD[*]="."' "\${fp}" > \${fp_out}
    echo "\${fp_out}"
  }

  # Run PURPLE
  java \
    -Xmx${task.memory.giga}g \
    -jar "${task.ext.jarPath}" \
      -reference "${meta.get(['sample_name', 'normal'])}" \
      -germline_vcf \$(get_smlv_arg ${smlv_normal_vcf}) \
      -amber "${amber}" \
      -cobalt "${cobalt}" \
      -output_dir purple/ \
      -gc_profile "${gc_profile}" \
      -run_drivers \
      -driver_gene_panel "${driver_gene_panel}" \
      -ensembl_data_dir "${ensembl_data_dir}" \
      -germline_hotspots "${known_hotspots_GERMLINE}"
      -ref_genome "${ref_data_genome_dir}/${ref_data_genome_fn}" \
      -ref_genome_version 38 \
      -threads "${task.cpus}" \
      -circos "${task.ext.path_circos}"

  # PURPLE can fail silently, check that at least the PURPLE SV VCF is created
  if [[ ! -s "purple/${meta.get(['sample_name', 'tumor'])}.purple.sv.vcf.gz" ]]; then
    exit 1;
  fi

  # NOTE(SW): hard coded since there is no reliable way to obtain version information
  cat <<-END_VERSIONS > versions.yml
    "${task.process}":
      purple: 3.4
  END_VERSIONS
  """

  stub:
  """
  mkdir purple/
  cat <<EOF > purple/${meta.get(['sample_name', 'tumor'])}.purple.sv.vcf.gz
  ##fileformat=VCFv4.1
  ##contig=<ID=.>
  #CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO
  .	.	.	.	.	.	.
  EOF
  echo -e '${task.process}:\\n  stub: noversions\\n' > versions.yml
  """
}
