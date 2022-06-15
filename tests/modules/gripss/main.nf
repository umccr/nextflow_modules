#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { GRIPSS } from '../../../modules/gripss/main.nf'

workflow test_gripss {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'SEQC-II_Tumor_50pc',
      ['sample_name', 'normal']: 'SEQC-II_Normal',
    ],
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/gridss_annotate/sv_vcf.annotated.vcf.gz',
      checkIfExists: true
    ),
  ]
  genome_dir = file('/Users/stephen/projects/gpl_reference_data/genome/umccrise_hg38/', checkIfExists: true)
  genome_fn = 'hg38.fa'
  gridss_breakend_pon = file('/Users/stephen/projects/gpl_reference_data/GRIDSS/38/gridss_pon_single_breakend.38.bed', checkIfExists: true)
  gridss_breakpoint_pon = file('/Users/stephen/projects/gpl_reference_data/GRIDSS/38/gridss_pon_breakpoint.38.bedpe', checkIfExists: true)
  gridss_known_fusions = file('/Users/stephen/projects/gpl_reference_data/Known-Fusions/38/known_fusions.38.bedpe', checkIfExists: true)

  // Run module
  GRIPSS(
    ch_input,
    genome_dir,
    genome_fn,
    gridss_breakend_pon,
    gridss_breakpoint_pon,
    gridss_known_fusions,
  )
}
