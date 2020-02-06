FROM meelis82/base-debian-bionic-for-docker:latest

MAINTAINER Meelis Valgeväli <meelis82@gmail.com>

LABEL vendor=custom

ENV TERM xterm

ADD ./src /src

RUN /src/entrypoint.sh build

VOLUME ["/mysql"]

EXPOSE 3306

ENTRYPOINT ["/src/entrypoint.sh", "run"]
