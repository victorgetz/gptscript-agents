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

create_combined_agent_file() {
    agents="$1"

    > "$MERGED_AGENT_FILE"
    for agent in ${agents}; do
        url=$(echo "${AGENTS_REGISTRY_URL}"/${agent}?raw=true | sed 's/,//g')
        curl -Ls "${url}" >> "$MERGED_AGENT_FILE"
    done

    # Extract names, exclude specific entries, and combine with commas
    agents=$(awk -F': ' '/^Name: / {print $2}' "$MERGED_AGENT_FILE" | grep -v "Your command line interface Bot" | grep -v "shared-context" | paste -sd ',' -)

    # Replace the placeholder with the extracted names
    sed -i "s|\${AGENTS}|$agents|g" "$MERGED_AGENT_FILE"

    echo "Processing complete. Merged file is: $MERGED_AGENT_FILE"
}

process_commands() {
    echo "$COMMANDS_JSON" | jq -c '.[]' | while read -r cmd; do
        command_string=$(echo "$cmd" | jq -r '.command')
        agents=$(echo "$cmd" | jq -r '.agents')
        model=$(echo "$cmd" | jq -r '.model')

        echo "------------------------"
        echo "Command: $command_string"
        echo "Agents: $agents"
        echo "Model: $model"
        echo "------------------------"

        create_combined_agent_file "$agents"

        gptscript --disable-cache --workspace . --default-model "$model" --openai-base-url "$OPENAI_BASE_URL" --openai-api-key "$OPENAI_API_KEY" "$MERGED_AGENT_FILE" "$command_string"
    done
}

configure_git

#Workdir
mkdir -p tmp/gptscript

echo "Will run gptscript against '$OPENAI_BASE_URL'"

process_commands "$COMMANDS"