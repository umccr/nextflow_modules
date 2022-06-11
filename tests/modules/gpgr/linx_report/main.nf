#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { LINX_REPORT } from '../../../modules/gpgr/linx_report/main.nf'

workflow test_linx_report {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      'PLACEHOLDER_linx_annotation',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_linx_visualiser',
      checkIfExists: true
    ),
  ]

  // Run module
  LINX_REPORT(
    ch_input,
  )
}
