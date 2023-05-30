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

## Usage Examples

Here are some examples of how to execute the script with and without providing an IP address:

- Execute the script without providing an IP address:

  ```bash
  ./ip_check.sh
  ```

  This will automatically fetch the current IP address and compare it with any provided IP address.

- Execute the script with a specific IP address:

  ```bash
  ./ip_check.sh 192.168.0.1
  ```

  This will fetch the current IP address and compare it with the provided IP address (192.168.0.1 in this example).

- Execute the script using the alias `ipcheck` without providing an IP address:

  ```bash
  ipcheck
  ```

  This will execute the script, using the alias `ipcheck`, and automatically fetch the current IP address.

- Execute the script using the alias `ipcheck` with a specific IP address:

  ```bash
  ipcheck 192.168.0.1
  ```

  This will execute the script, using the alias `ipcheck`, and fetch the current IP address, comparing it with the provided IP address (192.168.0.1 in this example).
