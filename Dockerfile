FROM gocd/gocd-agent-docker-dind:v18.7.0

RUN apk --no-cache add python py-pip openssl ca-certificates
RUN apk --update add --virtual build-dependencies python-dev libffi-dev build-base linux-headers \
  && pip install --no-cache-dir dvc \
  && apk del build-dependencies
