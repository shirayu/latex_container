
# LaTex container

My Development container for Latex

```bash
mkdir -p ~/.cache/latex_container
podman compose -f container/dev/compose.yaml build dev
podman compose -f container/dev/compose.yaml -p latex_container_dev up -d
```
