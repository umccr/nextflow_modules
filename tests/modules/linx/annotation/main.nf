#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { ANNOTATION } from '../../../modules/linx/annotation/main.nf'

workflow test_annotation {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      'PLACEHOLDER_purple_dir',
      checkIfExists: true
    ),
  ]
  linx_fragile_sites = file('PLACEHOLDER_linx_fragile_sites', checkIfExists: true)
  linx_lines = file('PLACEHOLDER_linx_lines', checkIfExists: true)
  hmf_ensembl_data_dir = file('PLACEHOLDER_hmf_ensembl_data_dir', checkIfExists: true)
  hmf_known_fusion_data = file('PLACEHOLDER_hmf_known_fusion_data', checkIfExists: true)
  hmf_driver_gene_pan = file('PLACEHOLDER_hmf_driver_gene_panel', checkIfExists: true)

  // Run module
  ANNOTATION(
    ch_input,
    linx_fragile_sites,
    linx_lines,
    hmf_ensembl_data_dir,
    hmf_known_fusion_data,
    hmf_driver_gene_pan,
  )
}
