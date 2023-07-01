## Install additional apt packages
sudo apt-get update && \
    sudo apt upgrade -y && \
    sudo apt-get install -y dos2unix libsecret-1-0 xdg-utils && \
    sudo apt clean -y && \
    sudo rm -rf /var/lib/apt/lists/*

## Configure git
git config --global pull.rebase false
git config --global core.autocrlf input

## Enable local HTTPS for .NET
dotnet dev-certs https --trust

## CaskaydiaCove Nerd Font
# Uncomment the below to install the CaskaydiaCove Nerd Font
mkdir $HOME/.local
mkdir $HOME/.local/share
mkdir $HOME/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip
unzip CascadiaCode.zip -d $HOME/.local/share/fonts
rm CascadiaCode.zip

## AZURE CLI EXTENSIONS ##
# Uncomment the below to install Azure CLI extensions
# extensions=$(az extension list-available --query "[].name" | jq -c -r '.[]')
# extensions=(account alias deploy-to-azure functionapp subscription webapp)
# for extension in $extensions;
# do
#     az extension add --name $extension
# done

## AZURE BICEP CLI ##
# Uncomment the below to install Azure Bicep CLI.
# az bicep install

## AZURE FUNCTIONS CORE TOOLS ##
# Uncomment the below to install Azure Functions Core Tools. Make sure you have installed node.js
# npm i -g azure-functions-core-tools@4 --unsafe-perm true

## Azurite ##
# Uncomment the below to install Azurite. Make sure you have installed node.js
# npm install -g azurite

## AZURE STATIC WEB APPS CLI ##
# Uncomment the below to install Azure Static Web Apps CLI. Make sure you have installed node.js
# npm install -g @azure/static-web-apps-cli

## AZURE DEV CLI ##
# Uncomment the below to install Azure Dev CLI. Make sure you have installed Azure CLI and GitHub CLI
# curl -fsSL https://aka.ms/install-azd.sh | bash

## GitHub Copilot CLI ##
# Uncomment the below to install GitHub Copilot CLI.
npm install -g @githubnext/github-copilot-cli
eval "$(github-copilot-cli alias -- "$0")"

## OH-MY-POSH ##
# Uncomment the below to install oh-my-posh
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
