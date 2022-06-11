FROM mambaorg/micromamba:0.24.0

RUN micromamba install -y -n base -c bioconda -c conda-forge \
    'hmftools-amber==3.9' \
    r-dplyr && \
  micromamba clean --all --yes
