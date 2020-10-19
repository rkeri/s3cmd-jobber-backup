FROM jobber:1.4.4-alpine3.11
MAINTAINER rkeri

USER root

# RUN apk add --no-cache bash
RUN apk --no-cache add curl

RUN apk add --no-cache python py-pip py-setuptools git ca-certificates

RUN pip install python-magic \
  && git clone https://github.com/s3tools/s3cmd.git /tmp/s3cmd \
  && cd /tmp/s3cmd \
  && python /tmp/s3cmd/setup.py install \
  && cd / \
  && rm -rf /tmp/s3cmd \
  && apk del py-pip git

ADD s3cfg /home/jobberuser/.s3cfg && \
  jobberfile /home/jobberuser/.jobber && \
  sh/* /home/jobberuser/

RUN chown jobberuser:jobberuser /home/jobberuser/* && \
  chmod 0600 /home/jobberuser/.s3cfg && \
  chmod 0600 /home/jobberuser/.jobber && \
  chmod +x /home/jobberuser/*.sh

USER jobberuser

ENTRYPOINT ["/home/jobberuser/start.sh"]
CMD [""]
