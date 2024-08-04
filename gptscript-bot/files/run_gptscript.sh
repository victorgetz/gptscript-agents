#bin/bash

#Git
#BOT_TOKEN="$GPTSCRIPT_BOT_TOKEN"
#GIT_URL="https://$BOT_TOKEN:$BOT_TOKEN@$CI_SERVER_HOST/$CI_PROJECT_PATH.git"
#BOT_EMAIL="gptscript-bot@iits-consulting.de"
#BOT_NAME="gptscript-bot"
#COMMIT_REF="$CI_COMMIT_REF_NAME"
#
##gptscript
#OPENAI_BASE_URL=""
#OPENAI_API_KEY=""
#
##COMMANDS_JSON="[ { "command": "ExampleCommand", "agents": "base.gpt, curl.gpt, cat.gpt", "model": "gpt-4o" } ]"
#
#AGENTS_REGISTRY_URL=""
#
#MERGED_AGENT_FILE="tmp/gptscript/combined.gpt"

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

        echo "------------------------"
        echo "Command: $command_string"
        echo "Model: $model"
        echo "------------------------"

        gptscript --disable-cache --workspace . --default-model "$model" --openai-base-url "$OPENAI_BASE_URL" --openai-api-key "$OPENAI_API_KEY" "$MERGED_AGENT_FILE" "$command_string"
    done
}

apk add --no-cache git libgcc curl jq ruby

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mkdir -p /usr/local/bin
mv kubectl /usr/local/bin/

configure_git

#Workdir
mkdir -p tmp/gptscript

echo "Will run gptscript against '$OPENAI_BASE_URL'"

process_commands "$COMMANDS"