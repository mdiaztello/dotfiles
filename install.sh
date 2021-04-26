
#!/bin/bash



function install_dotfiles
{
    for file in $(ls -d .[^.]*); do
        cp -r $file $HOME/$file
    done
}


# Vundle uses the .vimrc to deal with installing plugins, so make sure we've
# put the .vimrc in place first!
function install_vundle
{
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
}

function install_xmonad_config
{
    mkdir -p ~/.xmonad
    cp xmonad.hs ~/.xmonad/
}


function main
{
    install_dotfiles
    install_vundle
    install_xmonad_config
}


main
