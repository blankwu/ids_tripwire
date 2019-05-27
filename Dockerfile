FROM phusion/baseimage:0.10.0

USER root

WORKDIR /etc/tripwire

RUN apt-get update && apt-get install tripwire heirloom-mailx --yes
RUN rm /etc/tripwire/*

CMD ["sh", "tw_alert.sh"]
