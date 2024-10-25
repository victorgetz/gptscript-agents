# Usage
Go to the [iits.ai demo site](https://ai.iits.tech) and generate a API Key

![Selection_872](https://github.com/user-attachments/assets/174ed004-3a24-4f1d-846a-26ca251953cb)

```shell
export OPENAI_API_KEY="sk-6...."
export GPTSCRIPT_MODEL="gpt-4o"
export GPTSCRIPT_BOT_CONFIG="github.com/victorgetz/gptscript-agents/gptscript-bot/files/devops-bot.gpt"
export IITS_AI_BASE_URL="https://ai.iits.tech/backend/api"

alias gpt='gptscript --default-model "$GPTSCRIPT_MODEL" --workspace "$(dirname "$0")" --disable-cache --openai-base-url $IITS_AI_BASE_URL --openai-api-key "$OPENAI_API_KEY" $GPTSCRIPT_BOT_CONFIG $0'

# Usage
gpt show me all kubernetes pods
```
