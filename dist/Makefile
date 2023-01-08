namespace := $${NAMESPACE:-klausmeyer}
project := $${PROJECT:-timesheet}
version := $${VERSION:-0.1.0-dev}
registry := $${REGISTRY:-127.0.0.1:5000}
platforms := $${PLATFORMS:-linux/amd64,linux/arm64,linux/arm/v7}

all: clean docker-build helm-check helm-build helm-push helm-install

clean:
	rm -f *.tgz
	rm -f helm/$(project)/Chart.lock
	rm -rf helm/$(project)/charts/*

docker-build:
	docker buildx build --platform $(platforms) -t $(registry)/$(namespace)/$(project):$(version) --push ..

helm-bundle:
	helm dependency build helm/$(project)

helm-check: helm-bundle
	helm install --dry-run --generate-name --values helm/values.yaml helm/$(project)

helm-build: helm-bundle
	helm package helm/$(project)

helm-push: helm-build
	helm push *.tgz oci://$(registry)/helm-charts/$(namespace)/

helm-install:
	helm upgrade $(project) helm/$(project) --install --values helm/values.yaml --namespace $(project)
