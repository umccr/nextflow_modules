#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { PURPLE } from '../../../modules/purple/main.nf'

workflow test_gripss {
  // Set up inputs
  ch_input = [
    [
      ['sample_name', 'tumor']: 'TEST_sample_tumor',
      ['sample_name', 'normal']: 'TEST_sample_normal',
    ],
    file(
      'PLACEHOLDER_amber_dir',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_cobalt_dir',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_sv_soft_vcf_file',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_sv_soft_vcf_index_file',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_sv_hard_vcf_file',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_sv_hard_vcf_index_file',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_smlv_tumor_vcf',
      checkIfExists: true
    ),
    file(
      'PLACEHOLDER_smlv_normal_vcf',
      checkIfExists: true
    ),
  ]
  genome_dir = file('PLACEHOLDER_genome_dir', checkIfExists: true)
  genome_fn = 'PLACEHOLDER_genome_fn'
  cobalt_gc_profile = file('PLACEHOLDER_cobalt_gc_profile', checkIfExists: true)
  hmf_known_hotspots = file('PLACEHOLDER_hmf_known_hotspots', checkIfExists: true)
  hmf_driver_gene_panel = file('PLACEHOLDER_hmf_driver_gene_panel', checkIfExists: true)
  hmf_ensembl_data_dir = file('PLACEHOLDER_ensembl_data_dir', checkIfExists: true)

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
