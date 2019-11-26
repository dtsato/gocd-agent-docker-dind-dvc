FROM continuumio/miniconda3:4.7.12-alpine AS conda

MAINTAINER Danilo Sato <dtsato@gmail.com>

COPY requirements.txt .

USER root

ENV PATH=$PATH:/opt/conda/bin

RUN pip install --no-cache-dir --no-compile -r requirements.txt \
  && conda list && conda clean -tipy

FROM gocd/gocd-agent-docker-dind:v19.9.0
COPY --from=conda /opt/conda /opt/conda
ENV PATH=$PATH:/opt/conda/vin
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
