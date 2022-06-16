#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { ASSEMBLE } from '../../../../modules/gridss/assemble/main.nf'

workflow test_assemble {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
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
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/gridss_preprocess/SEQC-II_Tumor_50pc-ready.targeted.bam.gridss.working',
      checkIfExists: true
    ),
    file(
      'https://raw.githubusercontent.com/scwatts/nextflow_testdata/main/hmftools/gridss_preprocess/SEQC-II_Normal-ready.bam.gridss.working',
      checkIfExists: true
    ),
  ]
  genome_dir = file('./gpl_reference_data/genome/umccrise_hg38/', checkIfExists: true)
  genome_fn = 'hg38.fa'
  gridss_blacklist = file('./gpl_reference_data/GRIDSS/38/ENCFF356LFX.bed', checkIfExists: true)

  // Run module
  ASSEMBLE(
    ch_input,
    genome_dir,
    genome_fn,
    gridss_blacklist,
  )
}
