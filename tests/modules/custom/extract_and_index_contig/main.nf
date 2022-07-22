#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { EXTRACT_AND_INDEX_CONTIG } from '../../../../modules/custom/extract_and_index_contig/main.nf'

workflow test_extract_and_index_contig {
  // Set up inputs
  contig_name = 'chrM'
  genome_dir = file('./reference_data/genomes/', checkIfExists: true)
  genome_fn = 'hg38.fa'

  // Run module
  EXTRACT_AND_INDEX_CONTIG(
    contig_name,
    genome_dir,
    genome_fn,
  )
}
