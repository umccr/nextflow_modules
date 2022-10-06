#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { ASSEMBLE } from '../../../../modules/gridss/assemble/main.nf'

workflow test_assemble {
  // Set up inputs
  ch_input = [
    [:],
    [
      file(
        './nextflow_testdata/hmftools/gridss_extract_fragments/SEQC-II_Tumor_50pc-ready.targeted.bam',
        checkIfExists: true
      ),
      file(
        './nextflow_testdata/hmftools/read_sets/SEQC-II_Normal-ready.bam',
        checkIfExists: true
      ),
    ],
    [
      file(
        './nextflow_testdata/hmftools/gridss_preprocess/SEQC-II_Tumor_50pc-ready.targeted.bam.gridss.working',
        checkIfExists: true
      ),
      file(
        './nextflow_testdata/hmftools/gridss_preprocess/SEQC-II_Normal-ready.bam.gridss.working',
        checkIfExists: true
      ),
    ],
    ['TEST_sample_tumor', 'TEST_sample_normal'],
  ]
  gridss_config = file('./nextflow_testdata/hmftools/misc/gridss_config.txt', checkIfExists: true)
  genome_fa = file('./reference_data/genomes/GRCh38/hg38.fa', checkIfExists: true)
  genome_fai = file('./reference_data/genomes/GRCh38/samtools_index/1.12/hg38.fa.fai', checkIfExists: true)
  genome_dict = file('./reference_data/genomes/GRCh38/samtools_index/1.12/hg38.fa.dict', checkIfExists: true)
  genome_bwa_index_dir = file('./reference_data/genomes/GRCh38/bwamem2_index/0.7.17-r1188/', checkIfExists: true)
  genome_bwa_index_image = file('./reference_data/genomes/GRCh38/bwamem2_index/0.7.17-r1188/', checkIfExists: true)
  genome_gridss_index = file('./reference_data/genomes/GRCh38/gridss_index/2.13.2/hg38.fa.gridsscache', checkIfExists: true)
  gridss_blacklist = file('./reference_data/hmftools/gridss/ENCFF356LFX.bed.gz', checkIfExists: true)

  // Run module
  ASSEMBLE(
    ch_input,
    gridss_config,
    genome_fa,
    genome_fai,
    genome_dict,
    genome_bwa_index_dir,
    genome_bwa_index_image,
    genome_gridss_index,
    gridss_blacklist,
  )
}
