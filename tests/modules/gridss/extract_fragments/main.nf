#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { EXTRACT_FRAGMENTS } from '../../../modules/gridss/extract_fragments/main.nf'

workflow test_extract_fragments {
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
    file(
      'PLACEHOLDER_bai_file',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_manta_vcf_file',
      checkIfExists: true
    ),
  ]

  // Run module
  EXTRACT_FRAGMENTS(
    ch_input,
  )
}
