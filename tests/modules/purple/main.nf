#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { PURPLE } from '../../../modules/purple/main.nf'

workflow test_purple {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'SEQC-II_Tumor_50pc',
      ['sample_name', 'normal']: 'SEQC-II_Normal',
    ],
    file(
      './nextflow_testdata/hmftools/amber/',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/cobalt/',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/gripss/SEQC-II_Tumor_50pc.gripss.vcf.gz',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/gripss/SEQC-II_Tumor_50pc.gripss.vcf.gz.tbi',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/gripss/SEQC-II_Tumor_50pc.gripss.filtered.vcf.gz',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/gripss/SEQC-II_Tumor_50pc.gripss.filtered.vcf.gz.tbi',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/pave/SEQC-II.sage_somatic.pave.vcf.gz',
      checkIfExists: true
    ),
    file(
      './nextflow_testdata/hmftools/pave/SEQC-II.sage_germline.pave.vcf.gz',
      checkIfExists: true
    ),
    //[],
    //[],
  ]
  genome_fa = file('./reference_data/genomes/GRCh38/hg38.fa', checkIfExists: true)
  genome_fai = file('./reference_data/genomes/GRCh38/samtools_index/1.12/hg38.fa.fai', checkIfExists: true)
  genome_dict = file('./reference_data/genomes/GRCh38/samtools_index/1.12/hg38.fa.dict', checkIfExists: true)
  genome_ver = '38'
  cobalt_gc_profile = file('./reference_data/hmftools/cobalt/GC_profile.1000bp.38.cnp', checkIfExists: true)
  sage_known_hotspots_somatic = file('./reference_data/hmftools/sage/KnownHotspots.somatic.38.vcf.gz', checkIfExists: true)
  sage_known_hotspots_germline = file('./reference_data/hmftools/sage/KnownHotspots.germline.38.vcf.gz', checkIfExists: true)
  driver_gene_panel = file('./reference_data/hmftools/gene_panel/DriverGenePanel.38.tsv', checkIfExists: true)
  ensembl_data_dir = file('./reference_data/hmftools/ensembl_data_cache/', checkIfExists: true)
  germline_del_freq = file('./reference_data/hmftools/purple/cohort_germline_del_freq.38.csv', checkIfExists: true)

  // Run module
  PURPLE(
    ch_input,
    genome_fa,
    genome_fai,
    genome_dict,
    genome_ver,
    cobalt_gc_profile,
    sage_known_hotspots_somatic,
    sage_known_hotspots_germline,
    driver_gene_panel,
    ensembl_data_dir,
    germline_del_freq,
  )
}
