all:	build-gcc4 build-autobuilder

GCC4_SVN_DIR=gcc4/gcc4
GCC4_REV=$(shell svn info --show-item revision $(GCC4_SVN_DIR) | sed -e 's/ //g')
GCC4_CONTAINER_TAG=r$(GCC4_REV)
GCC4_CONTAINER_NAME=riscosdotinfo/riscos-gccsdk-4.7

AUTOBUILDER_SVN_DIR=autobuilder/autobuilder
AUTOBUILDER_REV=$(shell svn info --show-item revision $(AUTOBUILDER_SVN_DIR) | sed -e 's/ //g')
AUTOBUILDER_CONTAINER_TAG=r$(AUTOBUILDER_REV)
AUTOBUILDER_CONTAINER_NAME=riscosdotinfo/riscos-gccsdk-4.7-autobuilder

NUMPROC?=$(shell nproc)

export NUMPROC

build-autobuilder: build-gcc4 ${AUTOBUILDER_SVN_DIR}
	docker build -t ${AUTOBUILDER_CONTAINER_NAME}:${AUTOBUILDER_CONTAINER_TAG} -t ${AUTOBUILDER_CONTAINER_NAME}:latest autobuilder

${AUTOBUILDER_SVN_DIR}:
	svn co svn://svn.riscos.info/gccsdk/trunk/autobuilder ${AUTOBUILDER_SVN_DIR}

build-gcc4: ${GCC4_SVN_DIR}
	docker build -t ${GCC4_CONTAINER_NAME}:${GCC4_CONTAINER_TAG} -t ${GCC4_CONTAINER_NAME}:latest --build-arg NUMPROC=${NUMPROC} --build-arg MAKEFLAGS="-j${NUMPROC}" gcc4

${GCC4_SVN_DIR}:
	svn co svn://svn.riscos.info/gccsdk/trunk/gcc4 ${GCC4_SVN_DIR}

.PHONY:	update-all
update-all: ${AUTOBUILDER_SVN_DIR} ${GCC4_SVN_DIR}
	cd ${AUTOBUILDER_SVN_DIR} && svn up
	cd ${GCC4_SVN_DIR} && svn up

push: build
	docker push ${GCC4_CONTAINER_NAME}:${GCC4_CONTAINER_TAG} 
	docker push ${GCC4_CONTAINER_NAME}:latest
	docker push ${AUTOBUILDER_CONTAINER_NAME}:${AUTOBUILDER_CONTAINER_TAG} 
	docker push ${AUTOBUILDER_CONTAINER_NAME}:latest
