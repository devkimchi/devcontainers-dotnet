## OH-MY-ZSH PLUGINS & THEMES (POWERLEVEL10K) ##
# Uncomment the below to install oh-my-zsh plugins and themes (powerlevel10k) without dotfiles integration
# git clone https://github.com/zsh-users/zsh-completions.git $HOME/.oh-my-zsh/custom/plugins/zsh-completions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k --depth=1
# ln -s $HOME/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme $HOME/.oh-my-zsh/custom/themes/powerlevel10k.zsh-theme

## OH-MY-ZSH - POWERLEVEL10K SETTINGS ##
# Uncomment the below to update the oh-my-zsh settings without dotfiles integration
# curl https://raw.githubusercontent.com/justinyoo/devcontainers-dotnet/main/oh-my-zsh/.p10k-with-clock.zsh > $HOME/.p10k-with-clock.zsh
# curl https://raw.githubusercontent.com/justinyoo/devcontainers-dotnet/main/oh-my-zsh/.p10k-without-clock.zsh > $HOME/.p10k-without-clock.zsh
# curl https://raw.githubusercontent.com/justinyoo/devcontainers-dotnet/main/oh-my-zsh/switch-p10k-clock.sh > $HOME/switch-p10k-clock.sh
# chmod +x ~/switch-p10k-clock.sh

# cp $HOME/.p10k-with-clock.zsh $HOME/.p10k.zsh
# cp $HOME/.zshrc $HOME/.zshrc.bak

# echo "$(cat $HOME/.zshrc)" | awk '{gsub(/ZSH_THEME=\"codespaces\"/, "ZSH_THEME=\"powerlevel10k\"")}1' > $HOME/.zshrc.replaced && mv $HOME/.zshrc.replaced $HOME/.zshrc
# echo "$(cat $HOME/.zshrc)" | awk '{gsub(/plugins=\(git\)/, "plugins=(git zsh-completions zsh-syntax-highlighting zsh-autosuggestions)")}1' > $HOME/.zshrc.replaced && mv $HOME/.zshrc.replaced $HOME/.zshrc
# echo "
# # To customize prompt, run 'p10k configure' or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# " >> $HOME/.zshrc

## OH-MY-POSH - POWERLEVEL10K SETTINGS ##
# Uncomment the below to update the oh-my-posh settings without dotfiles integration
# curl https://raw.githubusercontent.com/justinyoo/devcontainers-dotnet/main/oh-my-posh/p10k-with-clock.omp.json > $HOME/p10k-with-clock.omp.json
# curl https://raw.githubusercontent.com/justinyoo/devcontainers-dotnet/main/oh-my-posh/p10k-without-clock.omp.json > $HOME/p10k-without-clock.omp.json
# curl https://raw.githubusercontent.com/justinyoo/devcontainers-dotnet/main/oh-my-posh/switch-p10k-clock.ps1 > $HOME/switch-p10k-clock.ps1

# mkdir -p $HOME/.config/powershell
# curl https://raw.githubusercontent.com/justinyoo/devcontainers-dotnet/main/oh-my-posh/Microsoft.PowerShell_profile.ps1 > $HOME/.config/powershell/Microsoft.PowerShell_profile.ps1
# curl https://raw.githubusercontent.com/justinyoo/devcontainers-dotnet/main/oh-my-posh/Microsoft.PowerShell_profile.ps1 > $HOME/.config/powershell/Microsoft.VSCode_profile.ps1

# cp $HOME/p10k-with-clock.omp.json $HOME/p10k.omp.json

## GitHub Copilot CLI ##
# Uncomment the below to install GitHub Copilot CLI.
### Add GitHub Copilot CLI alias to .zshrc
echo '
# Add GitHub Copilot CLI alias to .zshrc
alias ghcp='github-copilot-cli'
eval "$(github-copilot-cli alias -- "$0")"
' >> $HOME/.zshrc

### Add GitHub Copilot CLI alias to .bashrc
echo '
# Add GitHub Copilot CLI alias to .bashrc
alias ghcp='github-copilot-cli'
eval "$(github-copilot-cli alias -- "$0")"
' >> $HOME/.bashrc

### Add GitHub Copilot CLI alias to PowerShell profile
echo '
# Add GitHub Copilot CLI alias to PowerShell profile
Set-Alias ghcp /usr/local/share/nvm/current/bin/github-copilot-cli
function what-the-shell { ghcp what-the-shell $args }
function git-assist { ghcp git-assist $args }
function gh-assist { ghcp gh-assist $args }
Set-Alias ?? what-the-shell
Set-Alias git? git-assist
Set-Alias gh? gh-assist
' | sudo tee -a $HOME/.config/powershell/Microsoft.PowerShell_profile.ps1

### Add GitHub Copilot CLI alias to Integrated PowerShell profile
echo '
# Add GitHub Copilot CLI alias to Integrated PowerShell profile
Set-Alias ghcp /usr/local/share/nvm/current/bin/github-copilot-cli
function what-the-shell { ghcp what-the-shell $args }
function git-assist { ghcp git-assist $args }
function gh-assist { ghcp gh-assist $args }
Set-Alias ?? what-the-shell
Set-Alias git? git-assist
Set-Alias gh? gh-assist
' | sudo tee -a $HOME/.config/powershell/Microsoft.VSCode_profile.ps1
