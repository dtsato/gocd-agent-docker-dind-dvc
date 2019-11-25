FROM gocd/gocd-agent-docker-dind:v19.9.0

COPY requirements.txt .

USER root

RUN apk --no-cache add python3 openssl ca-certificates openblas-dev gfortran
RUN apk --update add --virtual build-dependencies python3-dev libffi-dev build-base linux-headers zlib-dev jpeg-dev freetype-dev libpng-dev \
  && pip3 install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir numpy==1.17.4 Cython==0.29.14 \
  && pip install --no-cache-dir -r requirements.txt \
  && apk del build-dependencies \
  && ln -sf /usr/bin/python3 /usr/bin/python

USER go
