# PATH configuration
export PATH="/usr/local/bin:$PATH"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Python 3.13
export PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:$PATH"

# Java setup
export JAVA_HOME=$(/usr/libexec/java_home -v 21.0.8)
export PATH=$JAVA_HOME/bin:$PATH