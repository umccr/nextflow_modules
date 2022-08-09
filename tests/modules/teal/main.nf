#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { TEAL } from '../../../modules/teal/main.nf'

workflow test_teal {
  // Set up inputs
  ch_input = [
    [
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
      './nextflow_testdata/hmftools/collectwgsmetrics/SEQC-II_Tumor_50pc-ready_wgs_metrics.txt',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/collectwgsmetrics/SEQC-II_Normal-ready_wgs_metrics.txt',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/cobalt/',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/purple/',
      checkIfExists: true
    ),
  ]

  // Run module
  TEAL(
    ch_input,
  )
}
