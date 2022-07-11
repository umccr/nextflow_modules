#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { REFDATA_PULL_DVC } from '../../../../modules/custom/refdata_pull_dvc/main.nf'

workflow test_refdata_pull_dvc {
  // Set up inputs
  ch_git_url = 'https://github.com/umccr/reference_data'
  ch_git_branch = 'dev'
  ch_dvc_remote = 'storage-s3'
  ch_filepaths = [
      'reference_data/hmftools/amber/GermlineHetPon.38.vcf.gz',
      'reference_data/hmftools/gene_panel/DriverGenePanel.38.tsv',
  ]

  // Run module
  REFDATA_PULL_DVC(
    ch_git_url,
    ch_git_branch,
    ch_dvc_remote,
    ch_filepaths,
  )
}
