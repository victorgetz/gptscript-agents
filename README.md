# Usage
Go to ai.iits.tech and generate a API Key

```shell
export OPENAI_API_KEY="sk-6...."

# add this to you bash/zsh alias
gptscript --default-model rag.mistral-nemo-12b --workspace "$(dirname "$0")" --disable-cache --openai-base-url "https://ai.iits.tech/backend/api" --openai-api-key "$OPENAI_API_KEY" github.com/victorgetz/gptscript-agents/gptscript-bot/files/devops-bot.gpt $0'
```