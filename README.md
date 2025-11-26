
# LaTex container

My Development container for Latex

```bash
mkdir -p .config/latex_container/output
podman compose -f container/dev/compose.yaml build dev
podman compose -f container/dev/compose.yaml -p latex_container_dev up -d
```
