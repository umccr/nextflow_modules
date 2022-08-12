#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { GRIPSS_SOMATIC } from '../../../../modules/gripss/somatic/main.nf'

workflow test_gripss_somatic {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'SEQC-II_Tumor_50pc',
      ['sample_name', 'normal']: 'SEQC-II_Normal',
    ],
    file(
      './nextflow_testdata/hmftools/gridss_annotate/sv_vcf.annotated.vcf.gz',
      checkIfExists: true
    ),
  ]
  genome_dir = file('./reference_data/genomes/', checkIfExists: true)
  genome_fn = 'hg38.fa'
  genome_ver = '38'
  gridss_breakend_pon = file('./reference_data/hmftools/gridss/gridss_pon_single_breakend.38.bed.gz', checkIfExists: true)
  gridss_breakpoint_pon = file('./reference_data/hmftools/gridss/gridss_pon_breakpoint.38.bedpe.gz', checkIfExists: true)
  gridss_known_fusions = file('./reference_data/hmftools/known_fusions/known_fusions.38.bedpe', checkIfExists: true)
  repeat_masker_file = file('./reference_data/hmftools/repeatmasker/38.fa.out.gz', checkIfExists: true)

  // Run module
  GRIPSS_SOMATIC(
    ch_input,
    genome_dir,
    genome_fn,
    genome_ver,
    gridss_breakend_pon,
    gridss_breakpoint_pon,
    gridss_known_fusions,
    repeat_masker_file,
  )
}
