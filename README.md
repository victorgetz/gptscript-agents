#Usage
Go to ai.iits.tech and generate a API Key

export OPENAI_API_KEY="sk-6...."
gptscript --default-model rag.mistral-nemo-12b --workspace "$(dirname "$0")" --disable-cache --openai-base-url "https://ai.iits.tech/backend/api" --openai-api-key "$OPENAI_API_KEY" ~/.gptscript/combined.gpt $0'