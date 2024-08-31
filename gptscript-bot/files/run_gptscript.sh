#bin/bash

configure_git() {
    git remote set-url origin "$GIT_URL"
    git config --global user.email "$BOT_EMAIL"
    git config --global user.name "$BOT_NAME"
    git checkout "$COMMIT_REF"
}

process_commands() {
    echo "$COMMANDS_JSON" | jq -c '.[]' | while read -r cmd; do
        command_string=$(echo "$cmd" | jq -r '.command')
        model=$(echo "$cmd" | jq -r '.model')
        botConfig=$(echo "$cmd" | jq -r '.botConfig')

        echo "------------------------"
        echo "Command: $command_string"
        echo "Model: $model"
        echo "------------------------"

        gptscript --default-model "$model" --workspace "$(dirname "$0")" --disable-cache --openai-base-url "$OPENAI_BASE_URL" --openai-api-key "$OPENAI_API_KEY" "$botConfig" "$command_string"
    done
}

configure_git

#Workdir
mkdir -p tmp/gptscript

echo "Will run gptscript against '$OPENAI_BASE_URL'"

process_commands "$COMMANDS"