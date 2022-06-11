process VISUALISER {
  conda (params.enable_conda ? "bioconda::hmftools-linx=1.19" : null)
  container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    'https://depot.galaxyproject.org/singularity/hmftools-linx:1.19--hdfd78af_0' :
    'quay.io/biocontainers/hmftools-linx:1.19--hdfd78af_0' }"

  input:
  tuple val(meta), path(linx)
  path(ensembl_data_dir)

  output:
  tuple val(meta), path('linx_visualiser/plot/'), emit: visualiser_dir
  path 'versions.yml'                           , emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  """
  java \
    -Xmx${task.memory.giga}g \
    -cp "${task.ext.jarPath}" \
    com.hartwig.hmftools.linx.visualiser.SvVisualiser \
      -sample "${meta.get(['sample_name', 'tumor'])}" \
      -ref_genome_version 38 \
      -ensembl_data_dir "${ensembl_data_dir}" \
      -plot_out linx_visualiser/plot \
      -data_out linx_visualiser/data \
      -vis_file_dir "${linx}" \
      -circos "${task.ext.path_circos}" \
      -threads "${task.cpus}"

  # NOTE(SW): hard coded since there is no reliable way to obtain version information
  cat <<-END_VERSIONS > versions.yml
    "${task.process}":
      linx: 1.19
  END_VERSIONS
  """

  stub:
  """
  mkdir -p linx_visualiser/plot/
  echo -e '${task.process}:\n  stub: noversions\n' > versions.yml
  """
}
