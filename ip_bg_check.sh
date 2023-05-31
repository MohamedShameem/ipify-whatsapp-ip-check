
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

# Function to show a local notification on Mac
show_notification() {
    echo "display notification \"$1\" with title \"IP Check\" sound name \"default\" " | osascript
}

# Function to check IP changes
check_ip_changes() {
    local stored_ip="$1"
    local current_ip

    while true; do
        current_ip=$(curl -s https://api.ipify.org)

        if [ "$current_ip" != "$stored_ip" ]; then
            echo "Your IP address has changed from $stored_ip to $current_ip."
            show_notification "Your IP address has changed to $current_ip."
            stored_ip="$current_ip"
            break
        fi

        sleep 5m
        echo "Checking for IP changes..."
    done
}

# Function to validate the IP address format
validate_ip_format() {
    local ip="$1"
    local valid_format="^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"

    if [[ ! $ip =~ $valid_format ]]; then
        echo "Invalid IP address format: $ip"
        exit 1
    fi
}

# Get the stored IP address
stored_ip=$(cat ~/.ipcheck_stored_ip 2>/dev/null)

# Get the current IP address
show_loading
current_ip=$(curl -s https://api.ipify.org)

if [ -z "$current_ip" ]; then
    echo "Sorry, unable to retrieve the IP address."
    exit 1
fi

# Check if an IP address was provided as an argument
if [ -n "$1" ]; then
    provided_ip="$1"

    # Validate the provided IP address format
    validate_ip_format "$provided_ip"

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
    whatsapp_url="https://wa.me/+96500000000?text=Hi,%20Please%20whitelist%20my%20IP%20$current_ip"

    # Open the WhatsApp message URL in the default browser
    open "$whatsapp_url"

    # Ask if the user wants to check IP changes in the background
    read -p "Do you want to check IP changes in the background? (y/n) " bg_choice

    if [[ $bg_choice =~ ^[Yy]$ ]]; then
        # Store the current IP address
        echo "$current_ip" > ~/.ipcheck_stored_ip

        # Run the IP change checker in the background
        check_ip_changes "$current_ip" &
        bg_pid=$!

        echo "IP change checker started in the background (PID: $bg_pid)."
        echo "To stop it, type 'ipcheckstop'."
    fi
else
    echo "Exiting the script."
    exit 0
fi

# Check for 'ipcheck stop' command to stop the background process
while true; do
    read -p "" cmd
    if [ "$cmd" == "ipcheck stop" ]; then
        echo "Stopping IP change checker (PID: $bg_pid)..."
        kill "$bg_pid"
        rm ~/.ipcheck_stored_ip
        echo "IP change checker stopped."
        break
    else
        echo "Invalid command. Type 'ipcheck stop' to stop the background process."
    fi
done
