PROJECT_NAME=app

# Docker
DOCKER_REGISTRY=vvelikodny
IMAGE=golang-starter-kit

all: $(PROJECT_NAME)

CGO_ENABLED=0
GOOS=linux
GOARCH=amd64

clean:
	@echo Remove previous bin ./$(PROJECT_NAME)
	[ ! -f ./$(PROJECT_NAME) ] || rm ./$(PROJECT_NAME)

$(PROJECT_NAME): clean
	@echo Building new bin for $(GOOS)/$(GOARCH)
	CGO_ENABLED=$(CGO_ENABLED) GOOS=$(GOOS) GOARCH=$(GOARCH) go build -a -installsuffix cgo -o $(PROJECT_NAME) ./cmd/$(PROJECT_NAME)

docker-build-image: $(PROJECT_NAME)
	docker build -t $(DOCKER_REGISTRY)/$(IMAGE) .

docker-push-image: docker-build
	docker push $(DOCKER_REGISTRY)/$(IMAGE)

docker-run: docker-build-image
	docker-compose up -d

docker-pull-and-run:
	docker pull $(DOCKER_REGISTRY)/$(IMAGE)
	docker-compose up -d

.PHONY: docker-run