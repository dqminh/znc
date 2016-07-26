VERSION := 1.6.3

.PHONY: build
build:
	docker build -t dqminh/znc:1.6.3 .

.PHONY: push
push: build
	docker push dqminh/znc:1.6.3
