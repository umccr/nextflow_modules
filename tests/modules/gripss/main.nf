#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { GRIPSS } from '../../../modules/gripss/main.nf'

workflow test_gripss {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      'PLACEHOLDER_gridss_vcf_file',
      checkIfExists: true
    ),
  ]
  genome_dir = file('PLACEHOLDER_genome_dir', checkIfExists: true)
  genome_fn = 'PLACEHOLDER_genome_fn'
  gridss_breakend_pon = file('PLACEHOLDER_gridss_breakend_pon', checkIfExists: true)
  gridss_breakpoint_pon = file('PLACEHOLDER_gridss_breakpoint_pon', checkIfExists: true)
  gridss_known_fusions = file('PLACEHOLDER_gridss_known_fusions', checkIfExists: true)

  // Run module
  GRIPSS(
    ch_input,
    genome_dir,
    genome_fn,
    gridss_breakend_pon,
    gridss_breakpoint_pon,
    gridss_known_fusions,
  )
}
