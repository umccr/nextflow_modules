#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { VISUALISER } from '../../../../modules/linx/visualiser/main.nf'

workflow test_visualiser {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'SEQC-II_Tumor_50pc',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/linx_annotation',
      checkIfExists: true
    ),
  ]
  hmf_ensembl_data_dir = file('/Users/stephen/projects/gpl_reference_data/Ensembl-Data-Cache/38/', checkIfExists: true)

  // Run module
  VISUALISER(
    ch_input,
    hmf_ensembl_data_dir,
  )
}
