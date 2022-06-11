FROM mambaorg/micromamba:0.24.0

RUN \
  micromamba install -y -n base -c bioconda -c conda-forge \
    'gridss==2.13.2' && \
  micromamba clean --all --yes

RUN \
  sed -i \
    -e '209s/grep samtools/head -n1 | grep samtools/' \
    /opt/conda/share/gridss-2.13.2-1/gridss_extract_overlapping_fragments
