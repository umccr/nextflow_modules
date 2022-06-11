#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { AMBER } from '../../../modules/amber/main.nf'

workflow test_amber {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      'PLACEHOLDER_tumor_bam_file',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_normal_bam_file',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_tumor_bai_file',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_normal_bai_file',
      checkIfExists: true
    ),
  ]
  amber_loci = file('PLACEHOLDER_amber_loci', checkIfExists: true)

  // Run module
  AMBER(
    ch_input,
    amber_loci,
  )
}
