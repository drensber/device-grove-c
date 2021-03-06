
.PHONY: build test clean docker

MICROSERVICES=build/release/device-grove-c/device-grove-c
.PHONY: $(MICROSERVICES)

DOCKERS=docker_device_grove_c
.PHONY: $(DOCKERS)

VERSION=$(shell cat ./VERSION || echo 0.0.0)
GIT_SHA=$(shell git rev-parse HEAD)

build: ${MICROSERVICES}

build/release/device-grove-c/device-grove-c:
	    scripts/build.sh

test:
	    @echo $(MICROSERVICES)

clean:
	    rm -f $(MICROSERVICES)

docker: $(DOCKERS)

docker_device_grove_c:
	    docker build \
	        -f scripts/Dockerfile.alpine-3.9 \
	        --label "git_sha=$(GIT_SHA)" \
	        -t edgexfoundry/docker-device-grove-c:${GIT_SHA} \
	        -t edgexfoundry/docker-device-grove-c:${VERSION}-dev \
            .