#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { EXTRACT_FRAGMENTS } from '../../../../modules/gridss/extract_fragments/main.nf'

workflow test_extract_fragments {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    'TEST_sample_name',
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/read_sets/SEQC-II_Tumor_50pc-ready.bam',
      checkIfExists: true
    ),
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/read_sets/SEQC-II_Tumor_50pc-ready.bam.bai',
      checkIfExists: true
    ),
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/structural_variants/SEQC-II-50pc-manta.vcf.gz',
      checkIfExists: true
    ),
  ]

  // Run module
  EXTRACT_FRAGMENTS(
    ch_input,
  )
}
