#! /bin/sh

black='\033[0;30m'
blue='\033[0;34m'
green='\033[0;32m'
cyan='\033[0;36m'
red='\033[0;31m'br
purple='\033[0;35m'
brown='\033[0;33m'
gray='\033[0;37m'
dark_gray='\033[1;30m'n
light_blue='\033[1;34m'
light_green='\033[1;32m'
light_cyan='\033[1;36m'
light_red='\033[1;31m'n
light_purple='\033[1;35m'
yellow='\033[1;33m'
white='\033[1;37m'

alias Reset="tput sgr0"      #  Reset text attributes to normal
                             #+ without clearing screen.

# Color-echo.
# Argument $1 = messageu
# Argument $2 = Colortt
cecho() {
    echo "${2}${1}"
    Reset # Reset to normal.
    return
}

# Set continue to false by default
CONTINUE=false
echo ""
cecho "###############################################" $red
cecho "#        DO NOT RUN THIS SCRIPT BLINDLY       #" $red
cecho "#         YOU'LL PROBABLY REGRET IT...        #" $red
cecho "#                                             #" $red
cecho "#              READ IT THOROUGHLY             #" $red
cecho "#         AND EDIT TO SUIT YOUR NEEDS         #" $red
cecho "###############################################" $red
echo ""

echo ""
cecho "Have you read through the script you're about to run and " $red
cecho "understood that it will make changes to your computer? (y/n)" $red
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi
if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  cecho "Please go read the script, it only takes a few minutes" $red
  exit
fi



echo ""
cecho "===================================================" $dark_gray
cecho "Install homebrew? (y/n)" $gray
cecho "===================================================" $dark_gray
read -r response
case $response in
  [yY])
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew update
    break;;
  *) break;;
esac


echo ""
cecho "===================================================" $dark_gray
cecho "Install brew utilities? (y/n)" $gray
cecho "===================================================" $dark_gray
read -r response
case $response in
  [yY])
    brew tap homebrew/x11 
    BREW_APPS="$(cat brew.txt)"
    echo "Installing brew packages"
    for BREW_APP in ${BREW_APPS}; do
      echo "Installing \"$BREW_APP\"..."
      brew install --force $BREW_APP
      echo "...installed \"$BREW_APP\"."
    done
    echo "Installing git-radar"
    brew install michaeldfallen/formula/git-radar
    echo "...installed git-radar"    
    break;;
  *) break;;
esac

echo ""
cecho "===================================================" $dark_gray
cecho "Install various versions of python? (y/n)" $gray
cecho "===================================================" $dark_gray
read -r response
case $response in
  [yY])
    echo ""
    cecho "Installing python versions" $gray
    pyenv install 2.7.8
    pyenv install 2.7.10
    pyenv global 2.7.10
    break;;
  *) break;;
esac

echo ""
cecho "===================================================" $dark_gray
cecho "Install python packages? (y/n)" $gray
cecho "===================================================" $dark_gray
read -r response
case $response in
  [yY])
    echo ""
    cecho "Installing some python packages" $gray
    sudo pip install flake8 doge thefuck glances saws
    break;;
  *) break;;
esac

echo ""
cecho "===================================================" $dark_gray
cecho "Install brew cask and apps? (y/n)" $gray
cecho "===================================================" $dark_gray
read -r response
case $response in
  [yY])
    echo ""
    cecho "Installing cask" $gray
    brew tap caskroom/versions
    brew cask update
    brew install caskroom/cask/brew-cask

    echo ""
    echo "Installing brew-cask apps"
    CASK_APPS="$(cat brew-cask.txt)"
    for CASK_APP in ${CASK_APPS}; do
      echo "Installing \"$CASK_APP\"..."
      brew cask install --force $CASK_APP
      echo "...installed \"$CASK_APP\"."
    done
    brew cask cleanup
    break;;
  *) break;;
esac

echo ""
cecho "===================================================" $dark_gray
cecho "Install fonts? (y/n)" $gray
cecho "===================================================" $dark_gray
read -r response
case $response in
  [yY])
    echo ""
    echo "Installing brew-cask fonts"
    brew tap caskroom/fonts
    fonts=(
      font-comic-neue
      font-droid-sans
      font-droid-sans-mono
      font-meslo-lg
      font-open-sans
      font-open-sans-condensed
      font-roboto
      font-source-code-pro
    )

    brew cask install ${fonts[@]}

    echo ""
    echo "Installing all Google Web Fonts"
    curl https://raw.githubusercontent.com/qrpike/Web-Font-Load/master/install.sh | sh

    echo ""
    echo "Downloading and installing Powerline fonts"
    wget https://github.com/powerline/fonts/archive/master.zip -O fonts.zip && unzip fonts.zip
    ./fonts-master/install.sh
    rm -r fonts.zip && rm -r fonts-master
    break;;
  *) break;;
esac

echo ""
cecho "===================================================" $dark_gray
cecho "Remember to download the OSX for Hackers script:" $gray
cecho "https://gist.github.com/brandonb927/3195465" $gray
cecho "===================================================" $dark_gray
