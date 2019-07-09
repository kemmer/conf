# -- Environment variables
source $SHCONFIG_PATH/env.zsh
source $SHCONFIG_PATH/sensitive.zsh

# -- Aliases
source $SHCONFIG_PATH/alias.zsh

# -- Functions and helpers
source $SHCONFIG_PATH/functions.zsh

# -- Exec at startup
(neofetch && echo "\n\n" && quote)
