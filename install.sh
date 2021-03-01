#!/bin/sh

bold=$(tput bold)
unbold=$(tput sgr0)

# Copy Fonts
echo "${bold}Copying fonts...${unbold}"
cp -rf fonts/. ~/Library/Fonts/


# Install Homebrew
if ! [ -x "$(command -v brew)" ]; then
  echo "${bold}Installing Homebrew...${unbold}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Homebrew is already installed."
fi


# Install Homebrew Bundle
# echo "Installing Homebrew Bundle..."
# brew tap homebrew/Bundle


# Install Homebrew Bundles
echo "${bold}Installing Homebrew bundles...${unbold}"
brew bundle --verbose --file homebrew/Brewfile


# Configure iTerm2
# echo "${bold}Configuring iTerm2...${unbold}"
# defaults delete com.googlecode.iterm2
# cp iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/
# defaults read -app iTerm


# Copy bash profile if none found
# if [ ! -f ~/.bash_profile ]; then
#   echo "Creating Bash profile..."
#   cp .bash_profile ~/.bash_profile
#   . ~/.bash_profile
# else
#   echo "Bash profile already exists. Copy extra settings in toolbox/.bash_profile manually."
# fi


# Configure Tmux
# if [ ! -f ~/.tmux.conf ]; then
#   echo "${bold}Configuring Tmux....${unbold}"
#   cp tmux/.tmux.conf ~/.tmux.conf
# else
#   echo "~/.tmux.conf already exists. Copy extra settings in toolbox/tmux/.tmux.conf manually."
# fi

# Install Oh-My-Zsh
if [ ! ~/.oh-my-zsh ]; then
  echo "${bold}Installing Oh-My-Zsh...${unbold}"
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
else
  echo "Oh My ZSH is already installed."
fi

# Install Powerline Theme
if [ ! ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
  echo "${bold}Installing Powerline Theme...${unbold}"
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
else
  echo "${bold}Powerline already installed.${unbold}"
fi

# Fix ZSH folder permissions
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

# Configure Zsh
if [ ! -f ~/.zshrc ]; then
  echo "${bold}Configuring Zsh....${unbold}"
  chsh -s /bin/zsh
  cp zsh/.zshrc ~/.zshrc
  source ~/.zshrc
else
  echo "~/.zshrc already exists. Copy extra settings in toolbox/tmux/.tmux.conf manually."
fi


# Configure Vim
if [ ! -f ~/.vimrc ]; then
  echo "${bold}Configuring Vim....${unbold}"
  cp vim/.vimrc ~/.vimrc
else
  echo "~/.vimrc already exists. Copy extra settings in toolbox/tmux/.tmux.conf manually."
fi

# If .vim folder does not have a colors folder, create it so we can paste the solarized theme
if [ ! -f ~/.vim/colors ]; then
  echo "${bold}Create Vim colors folder...${unbold}"
  mkdir ~/.vim/colors
else
  echo "Vim colors folder already exist."
fi


# Move solarized theme for Vim into the .vim/colors folder
cp vim/solarized.vim ~/.vim/colors/


# Install Vim Vundle (VIM Package Manager)
if [ ! -f ~/.vim/bundle/Vundle.vim ]; then
  echo "${bold}Vundle.vim doesn't exist. Creating...${unbold}"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  echo "Vundle.vim already exist. Skipping."
fi


echo "${bold}Installing Vundle...${unbold}"
vim +PluginInstall +qall


# Install Node
if ! [ -x "$(command -v npm)" ]; then
  echo "${bold}Installing Node... (Untested)${unbold}"
  nvm install node
else
  echo "Node already installed"
fi

# Install React Native CLI
echo "${bold}Installing React Native CLI${unbold}"
npx react-native

# Install Vtop
if ! [ -x "$(command -v vtop)" ]; then
  echo "${bold}Installing Vtop...${unbold}"
  npm install -g vtop
else
  echo "Vtop already installed"
fi


# Install PM2
echo "${bold}Installing PM2...${unbold}"
npm install -g pm2@latest


# Mac Configurations (Optional)
## Change Home/End keys to emulate IBM keyboard. [ref: https://tinyurl.com/ybqfobm2]
# if [ ! -f ~/Library/KeyBindings/DefaultKeyBinding.dict ]; then
  # echo "Modifying Mac Default Keyboard Bindings..."
  # cp os/KeyBindings/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
# else
  # echo "DefaultKeyBinding.dict already exists. Copy extra settings in toolbox/os/DefaultKeyBinding.dict manually."
# fi


# Fuzzy search plugin "fzf"
# To install useful key bindings and fuzzy completion
echo "${bold}Configure fzf plugin${unbold}"
$(brew --prefix)/opt/fzf/install


echo "${bold}Finished${unbold}"
brew info nvm

# Restart to load ZSH
zsh
