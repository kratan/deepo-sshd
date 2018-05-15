FROM ufoym/deepo:all-py36-jupyter

LABEL maintainer="Yoann VANITOU <yvanitou@gmail.com> + AK"

ENV DEBIAN_FRONTEND=noninteractive \
    TINI_VERSION=0.17.0 \
    TINI_SHA512SUM=772a4bfaefcb4293a31c1fbfe83a0f61e028a79aff6ef56cc33c061025689dd8ae071db5e417f466bc0b415da0c3aa2e6613e2c610128617e71d2fec9ee6f831 \
    BUILD_HOME=/tmp/home \
    BUILD_UID=1000 \
    BUILD_GID=1000

ADD https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini-amd64 /usr/local/bin/tini
RUN \
        echo "$TINI_SHA512SUM  /usr/local/bin/tini" | sha512sum -c \
        && chmod +x /usr/local/bin/tini


RUN apt-get update && \
    apt-get --yes install openssh-server virtualenv sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -vp /var/run/sshd
RUN mkdir -vp /usr/local/etc/sshd

COPY ./sshd/* /usr/local/etc/sshd/

RUN chmod -v 644 /usr/local/etc/sshd/*

VOLUME /usr/local/etc/sshd

COPY entrypoint.d/ /entrypoint.d/
COPY entrypoint.sh /

RUN chmod -v 755 /entrypoint.sh


EXPOSE 22
EXPOSE 8888

ENTRYPOINT ["/entrypoint.sh"]
