#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { COBALT } from '../../../modules/cobalt/main.nf'

workflow test_cobalt {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/read_sets/SEQC-II_Tumor_50pc-ready.bam',
      checkIfExists: true
    ),
    file(
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/read_sets/SEQC-II_Normal-ready.bam',
      checkIfExists: true
    ),
    file(
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/read_sets/SEQC-II_Tumor_50pc-ready.bam.bai',
      checkIfExists: true
    ),
    file(
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/read_sets/SEQC-II_Normal-ready.bam.bai',
      checkIfExists: true
    ),
  ]
  cobalt_gc_profile = file('./gpl_reference_data/Cobalt/38/GC_profile.1000bp.38.cnp', checkIfExists: true)

  // Run module
  COBALT(
    ch_input,
    cobalt_gc_profile,
  )
}
