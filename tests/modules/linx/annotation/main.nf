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
  linx_fragile_sites = file('./gpl_reference_data/Linx/38/fragile_sites_hmf.38.csv', checkIfExists: true)
  linx_lines = file('./gpl_reference_data/Linx/38/line_elements.38.csv', checkIfExists: true)
  hmf_ensembl_data_dir = file('./gpl_reference_data/Ensembl-Data-Cache/38/', checkIfExists: true)
  hmf_known_fusion_data = file('./gpl_reference_data/Known-Fusions/38/known_fusion_data.38.csv', checkIfExists: true)
  hmf_driver_gene_pan = file('./gpl_reference_data/Gene-Panel/38/DriverGenePanel.38.tsv', checkIfExists: true)

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
