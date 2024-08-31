FROM chainguard/gptscript:latest

# Install kubectl and git
RUN apk add --no-cache git libgcc curl jq ruby
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x kubectl
RUN mkdir -p /usr/local/bin
RUN mv kubectl /usr/local/bin/

# Verify the installation
RUN kubectl version --client
RUN git --version