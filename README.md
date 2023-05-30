# IP Check and Whitelisting Automation

This repository provides a script for automating the process of checking the current IP address and sending it via WhatsApp for whitelisting purposes.

## Features

- Automatically fetches the current IP address using the ipify API.
- Compares the provided IP address (if any) with the current IP.
- Interactive prompt to send the IP via WhatsApp for whitelisting.
- Opens the WhatsApp message URL in the default browser.

## Installation

1. Clone the repository to your local machine using the following command:

   ```bash
   git clone https://github.com/your-username/your-repository.git
   ```

   ```bash
   cd your-repository
   ```

2. Make the shell script executable by running the following command:

   ```bash
   chmod +x ip_check.sh
   ```

3. Now, you can run the script by executing the following command:

   ```bash
   ./ip_check.sh
   ```

4. Alternatively, you can create an alias to check it. Open your shell profile file (e.g., .bashrc, .bash_profile, .zshrc, etc.) using a text editor. For example:

   ```bash
   cd ~
   open ~/.zshrc
   ```

   Add the following line to the file, replacing `/path/to/ip_check.sh` with the actual path to your `ip_check.sh` file:

   ```bash
   alias ipcheck="/path/to/ip_check.sh"
   ```

   Save the file and exit the text editor.

5. Run the following command to apply the changes immediately:

   ```bash
   source ~/.zshrc
   ```

6. Now, you can run the script by typing `ipcheck` in the Terminal, and it will execute the `ip_check.sh` script.

   > Make sure to replace `/path/to/ip_check.sh` with the actual path to your `ip_check.sh` file when setting up the alias.
