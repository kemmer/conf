# zsh-setup
Framework-like structure for organizing different shell configurations. Optimized for ZSH (with Oh My Zsh framework).

## Highlights
- Separation for aliases, custom functions, environment variables
- Custom alias and functions that I use

## Installation
1. First, clone this repo to some desired folder that will hold all your configuration. This dir we call `SHCONFIG_PATH`.

2. Create a `sensitive.zsh` file inside `SHCONFIG_PATH`. Use this file if you want to hold sensitive environment variables.

3. Then, these variables need to be defined in your `.zshrc` file:
  - `SHCONFIG_EDITOR`: Your favorite editor command (vim, nvim, emacs, subl)
  - `SHCONFIG_PATH`: The folder that holds the files from this repo
  - `SHSTORAGE_PATH`: The folder for storing logs and other info (used in functions.zsh)

4. After that, include the line for sourcing the `boot.zsh` file, in your `.zshrc` file:
`source $SHCONFIG_PATH/boot.zsh`

### Required packages (for default configuration)
```git neofetch bat trash-cli```

### Required plugins (from Oh My Zsh)
```git rand-quote copyfile ```
