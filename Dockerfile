FROM alpine:3.9
MAINTAINER Chi Wai P <pzwa@pzwa.net>

ENV REGION="" ACCESS_KEY_ID="" ACCESS_KEY="" AWSCLI_CMD=""

RUN apk --no-cache add \
      bash \
      curl \
      python3  \
      py3-pip && \
      pip3 install --upgrade pip awscli s3cmd
# Add awsuser
RUN  addgroup -S awsuser && adduser -S awsuser -G awsuser -s /bin/bash
USER awsuser
# Add .aws directory
RUN  mkdir -p /home/awsuser/.aws
RUN  touch /home/awsuser/.aws/config
RUN  touch /home/awsuser/.aws/credentials
RUN  chmod 600 /home/awsuser/.aws/credentials


RUN  echo "[default]" >>  /home/awsuser/.aws/config
RUN  echo "[default]" >>  /home/awsuser/.aws/credentials

ENTRYPOINT echo "region = $REGION" >> /home/awsuser/.aws/config && \
           echo "aws_access_key_id = $ACCESS_KEY_ID" >>  /home/awsuser/.aws/credentials && \
           echo "aws_secret_access_key = $ACCESS_KEY" >>  /home/awsuser/.aws/credentials && \
           $AWSCLI_CMD
