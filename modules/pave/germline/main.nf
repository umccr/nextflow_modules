process PAVE_GERMLINE {
  //conda (params.enable_conda ? "bioconda::hmftools-pave=1.2" : null)
  container 'docker.io/scwatts/pave:1.2'

  input:
  tuple val(meta), path(sage_vcf)
  path ref_data_genome_dir
  val ref_data_genome_fn
  path ensembl_data_dir
  path driver_gene_panel
  path mappability_bed
  path clinvar_vcf
  path sage_blacklist_bed
  path sage_blacklist_vcf

  output:
  tuple val(meta), path("*.pave.vcf.gz")    , emit: vcf
  tuple val(meta), path("*.pave.vcf.gz.tbi"), emit: index
  path 'versions.yml'                       , emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  def args = task.ext.args ?: ''

  """
  java \
    -Xmx${task.memory.giga}g \
    -jar "${task.ext.jarPath}" \
      ${args} \
      -sample "${meta.get(['sample_name', 'tumor'])}" \
      -ref_genome_version 38 \
      -ref_genome "${ref_data_genome_dir}/${ref_data_genome_fn}" \
      -ensembl_data_dir "${ensembl_data_dir}" \
      -driver_gene_panel "${driver_gene_panel}" \
      -clinvar_vcf "${clinvar_vcf}" \
      -blacklist_bed "${sage_blacklist_bed}" \
      -blacklist_vcf "${sage_blacklist_vcf}" \
      -mappability_bed "${mappability_bed}" \
      -vcf_file "${sage_vcf}" \
      -read_pass_only \
      -output_dir ./

  # NOTE(SW): hard coded since there is no reliable way to obtain version information.
  cat <<-END_VERSIONS > versions.yml
    "${task.process}":
      pave: 1.2
  END_VERSIONS
  """

  stub:
  """
  touch ${meta.get(['sample_name', 'tumor'])}.sage.pave.vcf.gz{,.tbi}
  echo -e '${task.process}:\\n  stub: noversions\\n' > versions.yml
  """
}
