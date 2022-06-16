#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { ANNOTATION } from '../../../../modules/linx/annotation/main.nf'

workflow test_annotation {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'SEQC-II_Tumor_50pc',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/purple/',
      checkIfExists: true
    ),
  ]
  linx_fragile_sites = file('./reference_data/hmftools/linx/fragile_sites_hmf.38.csv', checkIfExists: true)
  linx_lines = file('./reference_data/hmftools/linx/line_elements.38.csv', checkIfExists: true)
  hmf_ensembl_data_dir = file('./reference_data/hmftools/ensembl_data_cache/', checkIfExists: true)
  hmf_known_fusion_data = file('./reference_data/hmftools/known_fusions/known_fusion_data.38.csv', checkIfExists: true)
  hmf_driver_gene_pan = file('./reference_data/hmftools/gene_panel/DriverGenePanel.38.tsv', checkIfExists: true)

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
