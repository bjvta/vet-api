COMMIT_SHA := $(shell git log -1 --pretty=format:"%h")
export COMMIT_SHA


.PHONY: default
default: 
	cd vet && bundle install --system

# create_db: bundle_install
# 	cd vet && bundle exec rake db:create

# migrate_db: create_db
# 	cd vet && bundle exec rake db:migrate


.PHONY: backend
backend:
	docker-compose run --rm --service-ports --use-aliases backend --shell

.PHONY: runserver
runserver:
	cd vet && rails s -b 0.0.0.0 -p 8000

