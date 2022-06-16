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
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/gridss_extract_fragments/SEQC-II_Tumor_50pc-ready.targeted.bam',
      checkIfExists: true
    ),
  ]
  genome_dir = file('./reference_data/genomes/', checkIfExists: true)
  genome_fn = 'hg38.fa'

  // Run module
  PREPROCESS(
    ch_input,
    genome_dir,
    genome_fn,
  )
}
