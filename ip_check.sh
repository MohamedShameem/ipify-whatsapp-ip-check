#!/bin/bash

# Function to show a loading indicator
show_loading() {
    local delay=0.1
    local count=0

    echo -n "Please wait, loading"

    while :; do
        printf "."
        sleep $delay

        ((count++))
        if ((count == 10)); then
            break
        fi
    done

    echo
}

# Function to handle failure in getting IP address
handle_ip_failure() {
    echo "Sorry, unable to retrieve the IP address."

    read -p "Do you want to try again? (y/n) " retry_choice

    if [[ $retry_choice =~ ^[Yy]$ ]]; then
        echo "Trying again..."
        run_ip_check
    else
        echo "Exiting the script."
        exit 0
    fi
}

# Function to run IP check
run_ip_check() {
    # Get the current IP address
    show_loading

    current_ip=$(curl -s https://api.ipify.org)

    if [ -z "$current_ip" ]; then
        handle_ip_failure
    fi

    # Check if an IP address was provided as an argument
    if [ -n "$1" ]; then
        provided_ip="$1"

        # Compare the provided IP with the current IP
        if [ "$provided_ip" = "$current_ip" ]; then
            echo "Your IP address has not changed ($current_ip)."
            read -p "Do you still want to send this to whitelist your IP? (y/n) " choice
        else
            echo "Your IP address has changed from $provided_ip to $current_ip."
            read -p "Do you want to send this new IP to whitelist your IP? (y/n) " choice
        fi
    else
        echo "Your current IP address is $current_ip."
        read -p "Do you want to send this to whitelist your IP? (y/n) " choice
    fi

    # Check if the user wants to send the IP via WhatsApp
    if [[ $choice =~ ^[Yy]$ ]]; then
        # Create the WhatsApp message URL
        whatsapp_url="https://wa.me/+96560954230?text=Hi,%20Please%20whitelist%20my%20IP%20$current_ip"

        # Open the WhatsApp message URL in the default browser
        open "$whatsapp_url"
    else
        echo "Exiting the script."
        exit 0
    fi
}

# Run the IP check
run_ip_check "$1"
