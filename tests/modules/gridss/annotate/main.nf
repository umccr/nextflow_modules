#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { ANNOTATE } from '../../../modules/gridss/annotate/main.nf'

workflow test_annotate {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      'PLACEHOLDER_gridss_vcf',
      checkIfExists: true
    ),
  ]

  // Run module
  ANNOTATE(
    ch_input,
  )
}
