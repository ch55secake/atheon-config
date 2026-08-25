# atheon-config
# Usage: just <command>

# Show available commands by default
default:
    @just --list

# Validate the flake without changing the machine
check:
    nix flake check

# Apply nix-darwin + Home Manager configuration
rebuild:
    sudo nix run github:nix-darwin/nix-darwin#darwin-rebuild -- switch --flake .

# Check first, then rebuild
apply: check rebuild

# Update all flake inputs
update:
    nix flake update

# Update inputs, validate, then rebuild
upgrade: update check rebuild

# Show what has changed in the config repo
diff:
    git diff

# Show repo status
status:
    git status --short

# Garbage collect old Nix store paths
gc:
    nix-collect-garbage -d
