#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { PREPROCESS } from '../../../modules/gridss/preprocess/main.nf'

workflow test_preprocess {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    'TEST_sample_name',
    file(
      'PLACEHOLDER_bam_file',
      checkIfExists: true
    ),
  ]
  genome_dir = file('PLACEHOLDER_genome_dir', checkIfExists: true)
  genome_fn = 'PLACEHOLDER_genome_fn'

  // Run module
  PREPROCESS(
    ch_input,
    genome_dir,
    genome_fn,
  )
}
