#!/bin/bash

set -e

echo "Upgrading pip..."
pip install --upgrade pip > /dev/null 2>&1

echo "Installing pre-commit..."
pip install pre-commit > /dev/null 2>&1

# Install thefuck from the GitHub repository as current release does not support Python 3.12 yet
echo "Installing thefuck..."
pip install git+https://github.com/nvbn/thefuck.git > /dev/null 2>&1

for shell_rc in ~/.zshrc ~/.bashrc; do
  if ! grep -q "eval \$(thefuck --alias)" "$shell_rc"; then
    echo "Adding thefuck alias to $shell_rc..."
    echo "eval \$(thefuck --alias)" >> "$shell_rc"
  else
    echo "Alias already present in $shell_rc"
  fi
done

echo "Postcreate success"
