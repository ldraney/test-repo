# GitHub CLI Docker Setup

Dockerized GitHub CLI with persistent auth and scripts for common operations.

## Quick Start

```bash
# Clone this repo
git clone https://github.com/yourusername/gh-cli-docker.git
cd gh-cli-docker
docker compose build

# Run auth script once to set up credentials
docker compose run --rm gh /scripts/auth.sh

# Initialize a new project (creates and pushes to a new repo)
docker compose run --rm gh /scripts/init-project.sh my-new-repo
```

## Alias
```bash
create-gh-repo() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a repository name"
        echo "Usage: create-gh-repo <repository-name>"
        return 1
    fi

    # Save current directory
    local current_dir=$(pwd)
    
    # Path to where your docker-compose.yml and Dockerfile live
    local docker_setup_dir="$HOME/projects/gh-cli-docker"
    
    echo "Creating repo '$1' in directory: $current_dir"
    
    # Go to docker setup directory
    cd "$docker_setup_dir"
    
    # Run the command using docker-compose
    COMPOSE_DOCKER_CLI_BUILD=1 docker compose run --rm \
        -v "${current_dir}:/workspace" \
        --no-deps \
        -w /workspace \
        --entrypoint /scripts/init-project.sh \
        gh "$1"
    
    # Return to original directory
    cd "$current_dir"
}
```

## Scripts

- `auth.sh`: One-time authentication that persists in a Docker volume
- `init-project.sh <repo-name>`: Creates a new repo and pushes current directory to it


## Optional Aliases

Add to `~/.bashrc` or `~/.zshrc`:
```bash
alias gh-docker='docker compose run --rm gh'
alias gh-init='docker compose run --rm gh /scripts/init-project.sh'
```

## Requirements

- Docker
- Docker Compose
