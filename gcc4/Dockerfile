FROM ubuntu:20.04 as ubuntu-base

FROM ubuntu-base as builder

WORKDIR /usr/src/gccsdk

COPY ./gcc4 gcc4

COPY ./gccsdk-params gcc4

ARG NUMPROC
ARG MAKEFLAGS

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y gcc g++ make m4 bison flex autogen patch gperf texinfo wget subversion

RUN cd gcc4 && ./build-world

FROM ubuntu-base

ENV GCCSDK_INSTALL_CROSSBIN=/home/riscos/cross/bin \
    GCCSDK_INSTALL_ENV=/home/riscos/env \
    PATH=/home/riscos/cross/bin:${PATH}

COPY --from=builder /home/riscos /home/riscos

CMD /bin/bash
