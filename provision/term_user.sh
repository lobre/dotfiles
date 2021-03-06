#!/bin/bash
#
# should be run as user (with sudo capabilities)

set -e

# Set default shell
sudo chsh -s /bin/zsh $USER

# Add current user to docker group
sudo usermod -aG docker $USER

# Install Prezto
rm -rf $HOME/.zprezto $HOME/.zlogin $HOME/.zlogout $HOME/.zpreztorc $HOME/.zprofile $HOME/.zshenv $HOME/.zshrc
git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.zprezto \
  && ln -s $HOME/.zprezto/runcoms/zlogin $HOME/.zlogin \
  && ln -s $HOME/.zprezto/runcoms/zlogout $HOME/.zlogout \
  && ln -s $HOME/.zprezto/runcoms/zpreztorc $HOME/.zpreztorc \
  && ln -s $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile \
  && ln -s $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv \
  && ln -s $HOME/.zprezto/runcoms/zshrc $HOME/.zshrc

# Install fzf
rm -rf $HOME/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf \
  && $HOME/.fzf/install --bin

# Install vim-go
git clone https://github.com/govim/govim.git $HOME/.vim/pack/plugins/start/govim

# Working dir
if [ ! -d "$HOME/Lab" ]; then
    mkdir $HOME/Lab

    # Create golang workspace paths
    mkdir -p $HOME/Lab/go \
        && mkdir $HOME/Lab/go/bin \
        && mkdir $HOME/Lab/go/pkg \
        && mkdir $HOME/Lab/go/src
fi

# Install golang apps
export GOROOT=/usr/local/go
export GOPATH="$HOME/Lab/go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

go get -u github.com/gokcehan/lf
go get -u github.com/sourcegraph/go-langserver
go get -u github.com/jesseduffield/lazygit
go get -u github.com/jesseduffield/lazydocker
go get -u github.com/mkchoi212/fac
#go get -u github.com/wagoodman/dive
go get -u github.com/containous/yaegi/cmd/yaegi

# Install dotfiles
if [ ! -d "$HOME/Lab/dotfiles" ]; then
    git clone https://github.com/loric-/dotfiles.git $HOME/Lab/dotfiles
fi
(cd $HOME/Lab/dotfiles && python3 link.py --only-terminal)

# Apply less layout
lesskey

# Install vim plugins
vim +'silent GoUpdateBinaries' +qa
