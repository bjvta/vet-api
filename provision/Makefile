COMMIT_SHA := $(shell git log -1 --pretty=format:"%h")
export COMMIT_SHA

build:
	cd docker && docker build \
		--target base \
		--tag bjason01/vet-api:latest \
		.

	cd docker && docker build \
		--target develop \
		--tag bjason01/vet-api:develop \
		.

push: build
	docker push \
		bjason01/vet-api:latest

	docker push \
		bjason01/vet-api:develop


# CMS APP usar esta imagen

