#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { COBALT } from '../../../modules/cobalt/main.nf'

workflow test_cobalt {
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
  cobalt_gc_profile = file('PLACEHOLDER_cobalt_gc_profile', checkIfExists: true)

  // Run module
  COBALT(
    ch_input,
    cobalt_gc_profile,
  )
}
