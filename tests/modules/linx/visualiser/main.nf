#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { VISUALISER } from '../../../modules/linx/visualiser/main.nf'

workflow test_visualiser {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      'PLACEHOLDER_linx_dir',
      checkIfExists: true
    ),
  ]
  hmf_ensembl_data_dir = file('PLACEHOLDER_hmf_ensembl_data_dir', checkIfExists: true)

  // Run module
  VISUALISER(
    ch_input,
    hmf_ensembl_data_dir,
  )
}
