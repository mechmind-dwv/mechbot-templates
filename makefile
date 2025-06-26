IMAGE_NAME = mechmind-dwv/mechbot-templates
VERSION = $(shell git rev-parse --short HEAD)

.PHONY: image
image:
	@docker build -t $(IMAGE_NAME):latest -t $(IMAGE_NAME):$(VERSION) .

.PHONY: push
push:
	@docker push $(IMAGE_NAME):latest
	@docker push $(IMAGE_NAME):$(VERSION)

.PHONY: compose-up
compose-up:
	@docker-compose up -d --build

.PHONY: compose-down
compose-down:
	@docker-compose down

.PHONY: test
test:
	@docker-compose exec web pytest tests/ -v --cov=.
