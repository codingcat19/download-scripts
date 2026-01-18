# This is where you will find Download Scripts
A collection of modular, architecture-aware shell scripts to set up a complete DevOps environment on Ubuntu/Debian.

# Quick Start
1. Clone the repo:
'''
git clone https://github.com/your-username/devops-tool-box.git
'''
'''
cd download-scripts
'''

2. Give permissions: 
'''
chmod -R +x .
'''

3. Run the scripts:
Example: Installing Docker
'''
./docker/install-docker.sh
'''

# Key Features
- **Architecture Detection:** Automatically detects x86_64 (Intel/AMD) vs aarch64 (ARM/Apple Silicon/Graviton) to fetch correct binaries.
- **Idempotency:** Scripts check if the tool is already installed before attempting to download.
- **Clean Uninstalls:** Dedicated uninstall scripts remove GPG keys, repositories, and binaries to keep your OS clean.
- **Permission Fixes:** The Docker script automatically handles the `unix:///var/run/docker.sock` permission denied error.

# License
This project is licensed under the MIT License - feel free to use and modify!