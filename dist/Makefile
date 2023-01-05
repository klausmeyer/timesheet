namespace := klausmeyer
project := timesheet
version := 0.1.0-dev
registry := registry.home.klaus-meyer.net

all: clean docker-build helm-check helm-build helm-push helm-install

clean:
	rm -f *.tgz
	rm -f helm/$(project)/Chart.lock
	rm -rf helm/$(project)/charts/*

docker-build:
	# docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t $(registry)/$(namespace)/$(project):$(version) --push ..
	docker buildx build --platform linux/arm64 -t $(registry)/$(namespace)/$(project):$(version) --load ..

helm-bundle:
	helm dependency build helm/$(project)

helm-check: helm-bundle
	helm install --dry-run --generate-name --values helm/values-verification.yaml helm/$(project)

helm-build: helm-bundle
	helm package helm/$(project)

helm-push: helm-build
	helm push *.tgz oci://$(registry)/helm-charts/$(namespace)/

helm-install:
	helm upgrade $(project) helm/$(project) --install --values helm/values-verification.yaml --namespace $(project)
