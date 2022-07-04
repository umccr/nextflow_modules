process ANNOTATE {
  //conda (params.enable_conda ? "bioconda::gridss=2.13.2" : null)
  container 'docker.io/scwatts/gridss:2.13.2'

  input:
  tuple val(meta), path(gridss_vcf)

  output:
  tuple val(meta), path('gridss_annotate/*.gridss.annotated.vcf.gz'), emit: vcf
  path('gridss_annotate/*.gridss.annotated.vcf.gz*')                , emit: vcf_and_index
  path 'versions.yml'                                               , emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  def args = task.ext.args ?: ''

  """
  gridss_annotate_vcf_repeatmasker \
    ${args} \
    --jar "${task.ext.jarPath}" \
    --output gridss_annotate/${meta.id}.gridss.annotated.vcf.gz \
    --workingdir gridss_annotate/work/ \
    --threads "${task.cpus}" \
    "${gridss_vcf}"

  # NOTE(SW): hard coded since there is no reliable way to obtain version information, see GH issue
  # https://github.com/PapenfussLab/gridss/issues/586
  cat <<-END_VERSIONS > versions.yml
    "${task.process}":
      gridss: 2.13.2
  END_VERSIONS
  """

  stub:
  """
  mkdir -p gridss_annotate/
  touch gridss_annotate/${meta.id}.gridss.annotated.vcf.gz
  echo -e '${task.process}:\\n  stub: noversions\\n' > versions.yml
  """
}
