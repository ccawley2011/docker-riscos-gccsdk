FROM riscosdotinfo/riscos-gccsdk-4.7

COPY ./autobuilder /home/riscos/autobuilder

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		cvs \
		subversion \
		autoconf \
		automake \
		wget \
		rman \
		pkg-config \
		doxygen \
		gettext \
		unzip \
		autoconf2.13 \
		flex \
		bison \
		gperf \
		libglib2.0-dev \
		xsltproc \
		intltool \
		automake1.11 \
		meson \
		cmake \
		ninja-build \
		git \
		patch \
		m4 \
		sed \
		make \
		dpkg-dev \
		help2man \
		autogen \
		libpopt-dev \
		policykit-1 \
		texinfo \
		libx11-dev \
		tcl \
		build-essential && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /home/riscos/build

CMD /bin/bash
