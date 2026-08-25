# atheon-config

Declarative macOS configuration powered by Nix.

This repository is the source of truth for my Mac: system settings, packages, applications, shell configuration, dotfiles, and development tooling are defined here rather than configured manually.

## Stack

* **Determinate Nix** — Nix installation and daemon
* **nix-darwin** — macOS system configuration
* **Home Manager** — user environment and dotfiles
* **Homebrew** — native macOS applications and Brew-only packages
* **Just** — interface for common configuration tasks

## Repository structure

```text
atheon-config/
├── flake.nix
├── flake.lock
├── configuration.nix
├── home.nix
├── justfile
└── config/
    ├── aerospace/
    │   └── aerospace.toml
    └── ghostty/
        └── config
```

### `flake.nix`

Defines and pins the core dependencies:

* nixpkgs
* nix-darwin
* Home Manager

The machine is exposed as the `atheon` Darwin configuration.

### `configuration.nix`

Machine-level macOS configuration.

This includes:

* system packages
* Homebrew
* native macOS applications
* macOS defaults
* keyboard configuration
* Dock configuration
* system-level Zsh support

Determinate owns the Nix installation itself, so nix-darwin is configured with:

```nix
nix.enable = false;
```

### `home.nix`

User-level configuration managed by Home Manager.

This includes:

* Git
* Zsh
* aliases
* CLI packages
* dotfiles
* `.hushlogin`
* application configuration links

Application configuration such as Ghostty and AeroSpace lives in this repository and is deployed into `~/.config` by Home Manager.

## Package ownership

As a general rule:

```text
Nix / Home Manager
├── CLI tools
├── Git
├── shell tooling
├── development tooling
└── dotfiles

Homebrew
├── native macOS applications
├── GUI applications
├── Homebrew casks
└── software where Brew is preferable to nixpkgs
```

Avoid installing software manually when it can reasonably be declared here.

If an application should permanently exist on the machine, add it to the configuration and rebuild.

If it should no longer exist, remove it from the configuration and rebuild.

## Applications

Native applications are managed declaratively through nix-darwin's Homebrew integration.

Current examples include:

* Ghostty
* AeroSpace
* PyCharm
* GoLand

AeroSpace uses its official Homebrew tap.

OpenCode is installed through its Homebrew tap.

## macOS configuration

macOS preferences are managed through nix-darwin where possible.

Current configuration includes:

* Caps Lock → Control
* automatically hidden Dock
* Dock recent applications disabled
* automatic Space reordering disabled

The goal is to avoid manually configuring System Settings when the preference can be expressed declaratively.

## Dotfiles

Home Manager owns user configuration files.

For example:

```text
config/ghostty/config
        ↓
~/.config/ghostty/config
```

and:

```text
config/aerospace/aerospace.toml
        ↓
~/.config/aerospace/aerospace.toml
```

This means application configuration is versioned alongside the rest of the machine.

## Commands

The `justfile` provides the primary interface for managing the machine.

Show available commands:

```bash
just
```

Validate the configuration:

```bash
just check
```

Apply the current configuration:

```bash
just apply
```

Update flake inputs:

```bash
just update
```

Update dependencies and apply the resulting configuration:

```bash
just upgrade
```

Inspect configuration changes:

```bash
just diff
```

## Normal workflow

Make changes to the repository:

```bash
$EDITOR home.nix
```

or:

```bash
$EDITOR configuration.nix
```

Then:

```bash
just check
just apply
```

Verify the changes and commit them:

```bash
git diff
git add .
git commit
git push
```

`flake.lock` is committed so the machine uses known versions of nixpkgs, nix-darwin, and Home Manager.

Updating dependencies is an explicit operation rather than something that happens on every rebuild.

## Fresh Mac bootstrap

The eventual goal is for provisioning a new Mac to be approximately:

### 1. Install Apple's Command Line Tools

```bash
xcode-select --install
```

### 2. Install Determinate Nix

Install Determinate Nix using its official macOS installer.

### 3. Configure GitHub access

Set up the minimum Git/SSH configuration required to clone this repository.

Do not store private SSH keys in this repository.

### 4. Clone the configuration

```bash
mkdir -p ~/Projects
cd ~/Projects
git clone <repository> atheon-config
cd atheon-config
```

### 5. Bootstrap nix-darwin

Before `just` and the normal shell environment exist:

```bash
sudo nix run github:nix-darwin/nix-darwin#darwin-rebuild -- switch --flake .
```

This activates nix-darwin and Home Manager.

### 6. Apply normally

After bootstrap:

```bash
just apply
```

From this point onward, configuration changes should happen through this repository rather than manual machine configuration.

## Philosophy

The repository describes the **desired state** of the machine.

Instead of:

> Install this package, change this setting, copy this dotfile.

the configuration says:

> This package exists, this setting has this value, and this dotfile has this content.

Nix, nix-darwin, Home Manager, and Homebrew are responsible for moving the machine toward that state.

The objective is that replacing the laptop should require as little knowledge of its previous manual configuration as possible.

Clone the repo, apply the configuration, and get the same environment back.

## Secrets

Secrets do **not** belong directly in the Nix configuration.

Do not commit:

* SSH private keys
* API tokens
* passwords
* credentials

Secret management should be handled separately with an appropriate encrypted secrets solution.

