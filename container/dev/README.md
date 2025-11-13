
# Development container

## Claude CLI

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

## Codex

```bash
pnpm install -g @openai/codex
codex login
```

Copy the url and access there by the host browser.
After login, copy the callback URL and run the following command.

```bash
curl curl -iL  {URL}
```

## GitHub copilot CLI

```bash
pnpm i -g install '@github/copilot'
```

```console
$ copilot
/login
```
