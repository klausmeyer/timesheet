# Timesheet

Ruby on Rails based "Timesheet" application.

Might not be useable by everyone ;)

## Installation

The application is designed to run inside Kubernetes.

### Requirements

* Make
* Docker
* Helm
* Kubernetes

### Workflow:

```shell
$ cd dist
$ make docker-build # Builds the docker-image
$ make docker-push  # Pushes it to a local registry (req.)
$ make helm-build   # Builds the helm-chart
$ make helm-push    # Pushes it to a local registry (req.)
$ make helm-install # Installs it in current k8s context
```
