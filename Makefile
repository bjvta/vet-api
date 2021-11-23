COMMIT_SHA := $(shell git log -1 --pretty=format:"%h")
export COMMIT_SHA


.PHONY: backend
backend:
	docker-compose run --rm --service-ports --use-aliases backend --shell



