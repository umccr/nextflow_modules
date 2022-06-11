process LINX_REPORT {
  conda (params.enable_conda ? "umccr::r-gpgr==1.2.5" : null)
  container 'docker.io/scwatts/gpr:1.2.5'

  input:
  tuple val(meta), path(linx_annotation), path(linx_visualiser)

  output:
  tuple val(meta), path('*_linx.html'), emit: html
  path 'versions.yml'                 , emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  """
  gpgr.R linx \
    --sample ${meta.get(['sample_name', 'tumor'])} \
    --plot ${linx_visualiser}/ \
    --table ${linx_annotation}/ \
    --out ${sample_name}_linx.html;

  # NOTE(SW): hard coded since there is no reliable way to obtain version information. Requested
  # feature from PD
  cat <<-END_VERSIONS > versions.yml
    "${task.process}":
      R: \$(R --version | head -n1 | sed 's/^R version \\([0-9.]\\+\\).\\+/\\1/')
      gpgr: 1.2.5
  END_VERSIONS
  """

  stub:
  """
  touch ${meta.get(['sample_name', 'tumor'])}_linx.html
  echo -e '${task.process}:\n  stub: noversions\n' > versions.yml
  """
}
