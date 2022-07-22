#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { REALIGN_READS_LILAC } from '../../../../modules/custom/realign_reads_lilac/main.nf'

workflow test_realign_reads_lilac {
  // Set up inputs
  ch_input = [
    ['id': 'TEST_sample'],
    file(
      './nextflow_testdata/hmftools/read_sets/SEQC-II_Tumor_50pc-ready.bam',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/read_sets/SEQC-II_Tumor_50pc-ready.bam.bai',
      checkIfExists: true
    ),
  ]
  reference_fp = file(
    './nextflow_testdata/hmftools/extract_and_index_contig/chrM_extracted.fa',
    checkIfExists: true
  )
  reference_index_fps = file(
    './nextflow_testdata/hmftools/extract_and_index_contig/chrM_extracted.fa.*',
    checkIfExists: true
  )

  // Run module
  REALIGN_READS_LILAC(
    ch_input,
    reference_fp,
    reference_index_fps,
  )
}
