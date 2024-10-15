#!/bin/sh

process_commands() {
    echo "$COMMANDS_JSON" | jq -c '.[]' | while read -r cmd; do
        command_string=$(echo "$cmd" | jq -r '.command')
        model=$(echo "$cmd" | jq -r '.model')
        botConfig=$(echo "$cmd" | jq -r '.botConfig')

        echo "------------------------"
        echo "Command: $command_string"
        echo "Model: $model"
        echo "Bot Config: $botConfig"
        echo "------------------------"

        gptscript --default-model "$model" --workspace "$(dirname "$0")" --disable-cache --openai-base-url "$OPENAI_BASE_URL" --openai-api-key "$OPENAI_API_KEY" "$botConfig" "$command_string"
    done
}

#Workdir
mkdir -p tmp/gptscript

echo "Will run gptscript against '$OPENAI_BASE_URL'"

process_commands "$COMMANDS"