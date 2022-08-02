#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { LINX_GERMLINE } from '../../../../modules/linx/germline/main.nf'

workflow test_linx_germline {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      './nextflow_testdata/hmftools/purple/SEQC-II_Tumor_50pc.purple.sv.vcf.gz',
      checkIfExists: true
    ),
  ]
  genome_ver = '38'
  linx_fragile_sites = file('./reference_data/hmftools/linx/fragile_sites_hmf.38.csv', checkIfExists: true)
  linx_lines = file('./reference_data/hmftools/linx/line_elements.38.csv', checkIfExists: true)
  hmf_ensembl_data_dir = file('./reference_data/hmftools/ensembl_data_cache/', checkIfExists: true)
  hmf_driver_gene_pan = file('./reference_data/hmftools/gene_panel/DriverGenePanel.38.tsv', checkIfExists: true)

  // Run module
  LINX_GERMLINE(
    ch_input,
    genome_ver,
    linx_fragile_sites,
    linx_lines,
    hmf_ensembl_data_dir,
    hmf_driver_gene_pan,
  )
}
