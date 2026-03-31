CHART    := /Users/brandon/src/day0/kitchensink-0.2.2.tgz
RELEASE  := 2048
NAMESPACE := 2048
IMAGE    := ghcr.io/bgulla/2048
TAG      := latest
HELM     := helm

.PHONY: install upgrade uninstall

install:
	$(HELM) upgrade --install $(RELEASE) $(CHART) \
		--namespace $(NAMESPACE) \
		--create-namespace \
		--set fullnameOverride=$(RELEASE) \
		--set image.repository=$(IMAGE) \
		--set image.tag=$(TAG) \
		--set service.port=8080

upgrade: install

uninstall:
	$(HELM) uninstall $(RELEASE) --namespace $(NAMESPACE)
