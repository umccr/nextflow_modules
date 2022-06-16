#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { CALL } from '../../../../modules/gridss/call/main.nf'

workflow test_call {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'SEQC-II_Tumor_50pc',
      ['sample_name', 'normal']: 'SEQC-II_Normal',
    ],
    file(
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/gridss_extract_fragments/SEQC-II_Tumor_50pc-ready.targeted.bam',
      checkIfExists: true
    ),
    file(
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/read_sets/SEQC-II_Normal-ready.bam',
      checkIfExists: true
    ),
    file(
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/gridss_assemble/',
      checkIfExists: true
    ),
  ]
  genome_dir = file('./gpl_reference_data/genome/umccrise_hg38/', checkIfExists: true)
  genome_fn = 'hg38.fa'
  gridss_blacklist = file('./gpl_reference_data/GRIDSS/38/ENCFF356LFX.bed', checkIfExists: true)

  // Run module
  CALL(
    ch_input,
    genome_dir,
    genome_fn,
    gridss_blacklist,
  )
}
