#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { LILAC } from '../../../modules/lilac/main.nf'

workflow test_lilac {
  // Set up inputs
  ch_input = [
    [
      'subject_name': 'TEST_subject',
      ['sample_name', 'tumor']: 'SEQC-II_Tumor_50pc',
      ['sample_name', 'normal']: 'SEQC-II_Normal',
    ],
    file(
      './nextflow_testdata/hmftools/read_sets/SEQC-II_Tumor_50pc-ready.bam',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/read_sets/SEQC-II_Normal-ready.bam',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/read_sets/SEQC-II_Tumor_50pc-ready.bam.bai',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/read_sets/SEQC-II_Normal-ready.bam.bai',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/purple/',
      checkIfExists: true
    ),
  ]
  genome_fa = file('./reference_data/genomes/GRCh38/hg38.fa', checkIfExists: true)
  genome_ver = '38'
  lilac_resource_dir = file('./reference_data/hmftools/lilac/', checkIfExists: true)

  // Run module
  LILAC(
    ch_input,
    genome_fa,
    genome_ver,
    lilac_resource_dir,
  )
}
