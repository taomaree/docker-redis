all: build

build:
	@docker build --tag=taomaree/redis .
	
release: build
	@docker build --tag=taomaree/redis:$(shell cat VERSION) .

debug: build
	@docker run -ti --rm taomaree/redis /bin/bash

run: build
	@docker run -ti --rm taomaree/redis

