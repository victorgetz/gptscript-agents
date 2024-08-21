# Usage
Go to ai.iits.tech and generate a API Key

```shell
export OPENAI_API_KEY="sk-6...."

# add this to you bash/zsh alias
alias gpt='gptscript --default-model llm.mistral-nemo-12b --workspace "$(dirname "$0")" --disable-cache --openai-base-url "https://ai.iits.tech/backend/api" --openai-api-key "$OPENAI_API_KEY" github.com/victorgetz/gptscript-agents/gptscript-bot/files/devops-bot.gpt $0'
alias gptOpenAI='gptscript --default-model llm.gpt-4o --workspace "$(dirname "$0")" --disable-cache --openai-base-url "https://ai.iits.tech/backend/api" --openai-api-key "$OPENAI_API_KEY" github.com/victorgetz/gptscript-agents/gptscript-bot/files/devops-bot.gpt $0'
# YOU NEED TO ORDER A CUSTOOMER TOKEN FOR THIS
alias gptRAG='gptscript --default-model llm.gpt-4o --workspace "$(dirname "$0")" --disable-cache --openai-base-url "https://ai.iits.tech/backend/api" --openai-api-key sk-"$OPENAI_API_KEY_CUSTOM_RAG_TOKEN" github.com/victorgetz/gptscript-agents/gptscript-bot/files/devops-bot.gpt $0'
alias gptlocal='gptscript --default-model llm.gpt-4o --workspace "$(dirname "$0")" --disable-cache --openai-base-url "https://ai.iits.tech/backend/api" --openai-api-key "$OPENAI_API_KEY" ~/.gptscript/combined.gpt $0'

# Usage

gpt show me all kubernetes pods
```
