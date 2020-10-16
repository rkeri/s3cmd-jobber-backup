FROM jobber:latest
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

ADD s3cfg /home/jobberuser/.s3cfg
ADD jobberfile /home/jobberuser/.jobber
ADD backup.sh /home/jobberuser/backup.sh
ADD win.sh /home/jobberuser/win.sh
ADD fail.sh /home/jobberuser/fail.sh
ADD start.sh /home/jobberuser/start.sh

RUN chown jobberuser:jobberuser /home/jobberuser/.jobber
RUN chown jobberuser:jobberuser /home/jobberuser/.s3cfg
RUN chown jobberuser:jobberuser /home/jobberuser/backup.sh
RUN chown jobberuser:jobberuser /home/jobberuser/fail.sh
RUN chown jobberuser:jobberuser /home/jobberuser/win.sh
RUN chown jobberuser:jobberuser /home/jobberuser/start.sh

RUN chmod 0600 /home/jobberuser/.s3cfg
RUN chmod 0600 /home/jobberuser/.jobber
RUN chmod +x /home/jobberuser/backup.sh
RUN chmod +x /home/jobberuser/win.sh
RUN chmod +x /home/jobberuser/fail.sh
RUN chmod +x /home/jobberuser/start.sh

USER jobberuser

ENTRYPOINT ["/home/jobberuser/start.sh"]
CMD [""]
