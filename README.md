# Go Web App - DevOps Project

A simple Go web application used as a hands-on DevOps learning project.

The application was originally forked from [Abhishek Veeramalla's Go web application](https://github.com/iam-veeramalla/go-web-app) and extended with a DevOps-focused workflow.

The project covers containerization, CI/CD, Kubernetes, Helm, GitOps, and NGINX Ingress.

## Architecture

```text
Developer
    |
    | git push
    v
  GitHub
    |
    v
GitHub Actions
    |
    +--> Build & Test
    |
    +--> Build Docker Image
    |
    +--> Push Image to Docker Hub
    |
    +--> Update Helm image tag
    |
    v
  GitHub
    |
    v
  Argo CD
    |
    v
Kind Kubernetes Cluster
    |
    v
NGINX Ingress
    |
    v
Go Web Application
```

## Tech Stack

| Technology | Purpose |
|------------|---------|
| Go | Web application |
| Git & GitHub | Source control |
| Docker | Containerization |
| Docker Hub | Container image registry |
| GitHub Actions | CI/CD automation |
| Kubernetes | Container orchestration |
| Kind | Local Kubernetes cluster |
| Helm | Kubernetes application packaging |
| Argo CD | GitOps deployment |
| NGINX Ingress | HTTP routing |

## Application

The application is a simple Go web application built with Go's `net/http` package.

The UI was customized as part of this DevOps project to give the application a personal touch.

![Application](docs/screenshots/application.jpg)

## CI/CD Pipeline

GitHub Actions automates the application and container image workflow.

The pipeline:

1. Checks out the repository
2. Sets up Go
3. Builds the Go application
4. Runs Go tests
5. Builds the Docker image
6. Pushes the image to Docker Hub
7. Updates the Docker image tag in the Helm chart
8. Commits and pushes the updated Helm values back to GitHub

The image tag uses the GitHub Actions run ID, for example:

```text
aditya3k4/go-web-app:36753695345
```

### GitHub Actions

![GitHub Actions](docs/screenshots/github-actions.jpg)

## Docker

The application is containerized using a multi-stage Dockerfile.

The builder stage compiles the Go application, while the final image uses a minimal `scratch` base image.

The application listens on port `8080`.

Build locally:

```bash
docker build -t go-web-app .
docker run -p 8080:8080 go-web-app
```

## Kubernetes

The application runs on a local Kind Kubernetes cluster.

Kubernetes resources include:

- Deployment
- ClusterIP Service
- Ingress

The Go application listens on port `8080`.

The Kubernetes Service exposes it internally on port `80`.

Request flow:

```text
Client
  |
  v
NGINX Ingress
  |
  v
go-web-app-service:80
  |
  v
Go Pod:8080
```

### Kubernetes

![Kubernetes](docs/screenshots/kubernetes.jpg)

## Helm

The Kubernetes application is packaged using a Helm chart:

```text
helm/
└── go-web-app-chart/
    ├── Chart.yaml
    ├── values.yaml
    └── templates/
        ├── deployment.yaml
        ├── service.yaml
        └── ingress.yaml
```

The Docker image tag is managed through `values.yaml`.

## GitOps with Argo CD

Argo CD watches the Helm chart stored in GitHub and synchronizes the desired state to the Kind Kubernetes cluster.

The deployment flow is:

```text
GitHub
   |
   v
Argo CD
   |
   v
Helm Chart
   |
   v
Kubernetes
```

![Argo CD](docs/screenshots/argocd.jpg)

## Ingress

NGINX Ingress is used to route HTTP traffic to the application.

The configured host is:

```text
go-web-app.com
```

For the local Kind environment, the hostname is mapped through `/etc/hosts`.

## Running Locally

### Run with Go

```bash
go run main.go
```

The application runs on:

```text
http://localhost:8080
```

### Run with Docker

```bash
docker build -t go-web-app .
docker run -p 8080:8080 go-web-app
```

### Deploy to Kind

Create or use a Kind cluster, then deploy the Helm chart:

```bash
kind create cluster
helm upgrade --install go-web-app ./helm/go-web-app-chart
```

Check the deployment:

```bash
kubectl get pods
kubectl get svc
kubectl get ingress
```

## Project Structure

```text
go-web-app-devops/
├── .github/
│   └── workflows/
│       └── ci.yaml
├── docs/
│   └── screenshots/
│       ├── application.jpg
│       ├── github-actions.jpg
│       ├── argocd.jpg
│       └── kubernetes.jpg
├── helm/
│   └── go-web-app-chart/
├── k8s/
│   └── manifests/
├── static/
├── Dockerfile
├── main.go
├── go.mod
└── README.md
```

## What I Practiced

This project was used to practice the complete DevOps workflow around a small application:

- Git and GitHub workflows
- Pull requests and code changes
- Docker image creation
- Docker Hub image publishing
- GitHub Actions CI/CD
- Kubernetes Deployments and Services
- Kubernetes Ingress
- Helm charts
- Kind local Kubernetes clusters
- Argo CD and GitOps
- Troubleshooting application and Kubernetes networking issues

The main goal was to understand how the pieces work together rather than only learning each tool independently.

## Screenshots

### Application

![Application](docs/screenshots/application.jpg)

### GitHub Actions

![GitHub Actions](docs/screenshots/github-actions.jpg)

### Argo CD

![Argo CD](docs/screenshots/argocd.jpg)

### Kubernetes

![Kubernetes](docs/screenshots/kubernetes.jpg)

## Author

**Aditya Singh**

Learning DevOps by building, deploying, troubleshooting, and documenting real projects.
