#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { CALL } from '../../../modules/gridss/call/main.nf'

workflow test_call {
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
      'PLACEHOLDER_assembled_dir',
      checkIfExists: true
    ),
  ]
  genome_dir = file('PLACEHOLDER_genome_dir', checkIfExists: true)
  genome_fn = 'PLACEHOLDER_genome_fn'
  gridss_blacklist = file('PLACEHOLDER_gridss_blacklist', checkIfExists: true)

  // Run module
  CALL(
    ch_input,
    genome_dir,
    genome_fn,
    gridss_blacklist,
  )
}
