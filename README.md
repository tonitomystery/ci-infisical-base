# ci-infisical-base

Imagen Docker pública para entornos CI/CD, basada en [`gitlab-org/cloud-deploy/aws-base`](https://registry.gitlab.com/gitlab-org/cloud-deploy/aws-base).

## Qué incluye

* **Infisical CLI** — para exportar secretos desde Infisical
* **curl** — para peticiones HTTP
* **zip** — para empaquetar archivos
* Herramientas base de AWS (AWS CLI, jq, etc.) provistas por la imagen `aws-base`

## Cómo hacer pull

```bash
docker pull DOCKERHUB_USERNAME/ci-infisical-base:latest
```

## Comprobar la versión de Infisical

```bash
docker run --rm DOCKERHUB_USERNAME/ci-infisical-base:latest infisical --version
```

## Uso en GitLab CI

```yaml
provision_app:
  image: DOCKERHUB_USERNAME/ci-infisical-base:latest

  script:
    - chmod +x scripts/*
    - ./scripts/aws_auth.sh
    - infisical export --domain="$INFISICAL_API_URL" --projectId="$INFISICAL_PROJECT_ID" --env=prod --format=dotenv > .env
    - ./scripts/create_docker_compose.sh
    - ./scripts/create_options.sh
    - ./scripts/update_source_bundle.sh
    - ./scripts/provision_app.sh
```

Todos los tools necesarios (`infisical`, `curl`, `zip`) ya están instalados en la imagen. No es necesario instalarlos en el pipeline de CI.

## Construir y publicar

Las imágenes se construyen y publican automáticamente en Docker Hub cuando se hace push a `main` o se ejecuta el workflow manualmente desde GitHub.

Requiere las siguientes GitHub Actions Secrets:

| Secret                | Descripción                        |
|-----------------------|------------------------------------|
| `DOCKERHUB_USERNAME`  | Nombre de usuario de Docker Hub    |
| `DOCKERHUB_TOKEN`     | Token de acceso personal de Docker Hub |
