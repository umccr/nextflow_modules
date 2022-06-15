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
      '/Users/stephen/repos/nextflow_testdata/hmftools/amber/',
      checkIfExists: true
    ),
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/cobalt/',
      checkIfExists: true
    ),
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/gripss/SEQC-II_Tumor_50pc.gripss.vcf.gz',
      checkIfExists: true
    ),
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/gripss/SEQC-II_Tumor_50pc.gripss.vcf.gz.tbi',
      checkIfExists: true
    ),
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/gripss/SEQC-II_Tumor_50pc.gripss.filtered.vcf.gz',
      checkIfExists: true
    ),
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/gripss/SEQC-II_Tumor_50pc.gripss.filtered.vcf.gz.tbi',
      checkIfExists: true
    ),
    file(
      '/Users/stephen/repos/nextflow_testdata/hmftools/small_variants/SEQC-II-50pc-ensemble-annotated.vcf.gz',
      checkIfExists: true
    ),
    null  // Normal sample small variants VCF file
  ]
  genome_dir = file('/Users/stephen/projects/gpl_reference_data/genome/umccrise_hg38/', checkIfExists: true)
  genome_fn = 'hg38.fa'
  cobalt_gc_profile = file('/Users/stephen/projects/gpl_reference_data/Cobalt/38/GC_profile.1000bp.38.cnp', checkIfExists: true)
  hmf_known_hotspots = file('/Users/stephen/projects/gpl_reference_data/Sage/38/KnownHotspots.somatic.38.vcf.gz', checkIfExists: true)
  hmf_driver_gene_panel = file('/Users/stephen/projects/gpl_reference_data/Gene-Panel/38/DriverGenePanel.38.tsv', checkIfExists: true)
  hmf_ensembl_data_dir = file('/Users/stephen/projects/gpl_reference_data/Ensembl-Data-Cache/38', checkIfExists: true)

  // Run module
  PURPLE(
    ch_input,
    genome_dir,
    genome_fn,
    cobalt_gc_profile,
    hmf_known_hotspots,
    hmf_driver_gene_panel,
    hmf_ensembl_data_dir,
  )
}
