IMAGE           := marrold/cutel-rtpengine
TAG             := latest
PLATFORM        := linux/amd64
RTPENGINE_TAG   := mr13.5.1.10

.PHONY: build push

build:
	docker buildx build -t "$(IMAGE):$(TAG)" --platform $(PLATFORM) --build-arg RTPENGINE_TAG=$(RTPENGINE_TAG) .

push:
	docker buildx build -t "$(IMAGE):$(TAG)" --platform $(PLATFORM) --build-arg RTPENGINE_TAG=$(RTPENGINE_TAG) --push .
