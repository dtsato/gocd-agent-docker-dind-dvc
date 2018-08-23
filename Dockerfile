FROM gocd/gocd-agent-docker-dind:v18.7.0

RUN apk --no-cache add python3 openssl ca-certificates
RUN apk --update add --virtual build-dependencies python3-dev libffi-dev build-base linux-headers \
  && pip3 install --no-cache-dir dvc \
  && apk del build-dependencies \
  && if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi \
  && [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi
