# ci-infisical-base

Imagen Docker pública para entornos CI/CD, basada en [`gitlab-org/cloud-deploy/aws-base`](https://registry.gitlab.com/gitlab-org/cloud-deploy/aws-base).

## Qué incluye

* **Infisical CLI** — para exportar secretos desde Infisical
* **curl** — para peticiones HTTP
* **zip** — para empaquetar archivos
* Herramientas base de AWS (AWS CLI, jq, etc.) provistas por la imagen `aws-base`

## Cómo hacer pull

```bash
docker pull amaristany/ci-infisical-aws:latest
```

## Comprobar la versión de Infisical

```bash
docker run --rm amaristany/ci-infisical-aws:latest infisical --version
```

## Uso en GitLab CI

```yaml
provision_app:
  image: amaristany/ci-infisical-aws:latest

  script:
     - export INFISICAL_TOKEN=$(infisical login --method=universal-auth --client-id="$INFISICAL_CLIENT_ID" --client-secret="$INFISICAL_CLIENT_SECRET" --domain="$INFISICAL_API_URL" --plain)
    - infisical export --domain="$INFISICAL_API_URL" --projectId="$INFISICAL_PROJECT_ID" --env=prod --format=dotenv > .env

```

Todos los tools necesarios (`infisical`, `curl`, `zip`) ya están instalados en la imagen. No es necesario instalarlos en el pipeline de CI.

## Construir y publicar

Las imágenes se construyen y publican automáticamente en Docker Hub cuando se hace push a `main` o se ejecuta el workflow manualmente desde GitHub.

Requiere las siguientes GitHub Actions Secrets:

| Secret                | Descripción                        |
|-----------------------|------------------------------------|
| `DOCKERHUB_USERNAME`  | Nombre de usuario de Docker Hub    |
| `DOCKERHUB_TOKEN`     | Token de acceso personal de Docker Hub |
