#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { PREPROCESS } from '../../../../modules/gridss/preprocess/main.nf'

workflow test_preprocess {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    'TEST_sample_name',
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/gridss_extract_fragments/SEQC-II_Tumor_50pc-ready.targeted.bam',
      checkIfExists: true
    ),
  ]
  genome_dir = file('/Users/stephen/projects/gpl_reference_data/genome/umccrise_hg38/', checkIfExists: true)
  genome_fn = 'hg38.fa'

  // Run module
  PREPROCESS(
    ch_input,
    genome_dir,
    genome_fn,
  )
}
