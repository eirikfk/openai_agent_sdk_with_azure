#!/bin/bash

# Function to print messages in red
print_red() {
    echo -e "\e[31m$@\e[0m"
}

# Function to print messages in green
print_green() {
    echo -e "\e[32m$@\e[0m"
}

# Initialize a variable to keep track of any errors
error_count=0

# Function to check if a command is installed
check_command_installed() {
    local command=$1

    if ! command -v "$command" &> /dev/null; then
        print_red "Error: $command is not installed."
        error_count=$((error_count+1))
        return 1
    fi
    return 0
}

# Function to get the installed version of a command
get_installed_version() {
    local command=$1

    local installed_version=$("$command" --version 2>&1 | grep -oP '\d+\.\d+' | head -n1)
    if [[ -z "$installed_version" ]]; then
        print_red "Error: Unable to determine the installed version of $command."
        error_count=$((error_count+1))
        return 1
    fi
    echo "$installed_version"
    return 0
}

# Function to compare versions
compare_versions() {
    local installed_version=$1
    local required_version=$2

    IFS='.' read -r req_major req_minor <<< "$required_version"
    IFS='.' read -r inst_major inst_minor <<< "$installed_version"

    # Default minor versions to 0 if they are not specified
    req_minor=${req_minor:-0}
    inst_minor=${inst_minor:-0}

    if [[ "$inst_major" -gt "$req_major" ]] || { [[ "$inst_major" -eq "$req_major" ]] && [[ "$inst_minor" -ge "$req_minor" ]]; }; then
        return 0
    else
        return 1
    fi
}

# Main function to check the version of a command
check_version() {
    local command=$1
    local required_version=$2

    check_command_installed "$command" || return

    if [[ -z "$required_version" ]]; then
        print_green "$command is installed."
        return
    fi

    local installed_version
    installed_version=$(get_installed_version "$command") || return

    if compare_versions "$installed_version" "$required_version"; then
        print_green "$command version $installed_version is installed and meets the requirement of version $required_version."
    else
        print_red "Error: $command version $required_version or greater is required. Current version: $installed_version"
        error_count=$((error_count+1))
    fi
}

# Function to check for required files
check_files() {
    for file in "$@"; do
        if [[ ! -f "$file" ]]; then
            print_red "Error: Missing required file: $file"
            error_count=$((error_count+1))
        else
            print_green "Found required file: $file"
        fi
    done
}

# Function to print the final status of the environment check
print_final_status() {
    if [[ "$error_count" -gt 0 ]]; then
        echo "Environment check completed with $error_count error(s). Please review the log and fix the issues."
        exit 1
    else
        echo "All checks passed successfully."
    fi
}
