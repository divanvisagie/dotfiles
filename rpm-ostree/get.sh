#!/bin/bash

# Function to get layered packages from the currently booted rpm-ostree deployment
get_packages() {
    rpm-ostree status --json | jq -r '.deployments[] | select(.booted == true) | .packages[]' | sort
}

# Function to generate install script
generate_install_script() {
    echo "#!/bin/bash"
    echo ""
    echo "# Auto-generated rpm-ostree install script"
    echo "# Generated on $(date)"
    echo ""
    echo "set -e"
    echo ""
    echo "echo 'Installing layered packages...'"
    echo -n "rpm-ostree install"
    
    # Get packages and format them for the install command
    get_packages | while read package; do
        echo " \\"
        echo -n "    $package"
    done
    echo ""
    echo ""
    echo "echo 'Installation complete! Reboot to apply changes.'"
}

# Check for --generate flag
if [[ "$1" == "--generate" ]]; then
    generate_install_script
else
    get_packages
fi