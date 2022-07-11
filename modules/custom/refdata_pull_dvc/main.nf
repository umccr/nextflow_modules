process REFDATA_PULL_DVC {
  //conda (params.enable_conda ? "dvc:2.12.1" : null)
  container 'docker.io/scwatts/dvc:2.12.1'

  input:
  val git_url
  val git_branch
  val dvc_remote
  val filepaths

  output:
  path 'reference_data/', emit: refdata_dir
  path 'versions.yml',             emit: versions

  when:
  task.ext.when == null || task.ext.when

  script:
  def args = task.ext.args ?: ''
  def args2 = task.ext.args2 ?: ''
  def git_branch_arg = git_branch ? "-b ${git_branch}" : ''
  def dvc_remote_arg = dvc_remote ? "--remote ${dvc_remote}" : ''
  def filepaths_list = filepaths instanceof List ? filepaths : [filepaths]
  def filepaths_args = filepaths_list.join(' ')

  """
  git clone ${args} ${git_branch_arg} ${git_url} git_repo/

  (
    cd git_repo/;
    dvc pull \
      ${args2} \
      ${dvc_remote_arg} \
      ${filepaths_args};
  )

  ln -s git_repo/reference_data/ ./

  cat <<-END_VERSIONS > versions.yml
    "${task.process}":
      dvc: \$(dvc --version)
      git: \$(git --version | cut -f3 -d' ')
  END_VERSIONS
  """

  stub:
  """
  mkdir -p git_repo/reference_data/
  echo -e '${task.process}:\\n  stub: noversions\\n' > versions.yml
  """
}
