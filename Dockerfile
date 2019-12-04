FROM continuumio/miniconda3:4.7.12-alpine AS conda

MAINTAINER Danilo Sato <dtsato@gmail.com>

COPY requirements.txt .

USER root

ENV PATH=$PATH:/opt/conda/bin

RUN pip install --no-cache-dir --no-compile -r requirements.txt \
  && conda list && conda clean -tipy \
  && echo "conda activate base" >> /etc/profile.d/conda-activate

FROM gocd/gocd-agent-docker-dind:v19.11.0
COPY --from=conda /opt/conda /opt/conda
COPY --from=conda /etc/profile.d /etc/profile.d
ENV PATH=/opt/conda/bin:$PATH
