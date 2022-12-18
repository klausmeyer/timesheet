namespace := klausmeyer
project := timesheet
version := 0.1.0-dev
# registry := registry.home.klaus-meyer.net
registry := 127.0.0.1:5000

all: clean docker-push helm-check helm-build helm-push helm-install

clean:
	rm -f *.tgz
	rm -f helm/$(project)/Chart.lock
	rm -rf helm/$(project)/charts/*

docker-build:
	docker build -t $(registry)/$(namespace)/$(project):$(version) ..

docker-push: docker-build
	docker push $(registry)/$(namespace)/$(project):$(version)

helm-bundle:
	helm dependency build helm/$(project)

helm-check: helm-bundle
	helm install --dry-run --generate-name --values helm/values-verification.yaml helm/$(project)

helm-build: helm-bundle
	helm package helm/$(project)

helm-push: helm-build
	helm push *.tgz oci://$(registry)/helm-charts/$(namespace)/

helm-install:
	helm upgrade $(project) helm/$(project) --install --values helm/values-verification.yaml
