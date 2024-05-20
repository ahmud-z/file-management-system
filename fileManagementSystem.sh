#!/bin/bash

# Function to display menu
display_menu() {
    echo "File Management System"
    echo "1. Create a file"
    echo "2. Delete a file"
    echo "3. Move a file"
    echo "4. List files in a directory"
    echo "5. Create a directory"
    echo "6. Delete a directory"
    echo "7. Copy a file"
    echo "8. Rename a file or directory"
    echo "9. Search for files"
    echo "10. Exit"
    echo "11. Clear Display"
    echo -n "Enter your choice [1-10]: "
}

# Function to create a file
create_file() {
    echo -n "Enter the filename to create: "
    read filename
    touch "$filename"
    echo "File '$filename' created."
}

# Function to delete a file
delete_file() {
    echo -n "Enter the filename to delete: "
    read filename
    if [ -f "$filename" ]; then
        rm "$filename"
        echo "File '$filename' deleted."
    else
        echo "File '$filename' not found."
    fi
}

# Function to move a file
move_file() {
    echo -n "Enter the filename to move: "
    read filename
    if [ -f "$filename" ]; then
        echo -n "Enter the destination directory: "
        read dest
        if [ -d "$dest" ]; then
            mv "$filename" "$dest"
            echo "File '$filename' moved to '$dest'."
        else
            echo "Directory '$dest' not found."
        fi
    else
        echo "File '$filename' not found."
    fi
}

# Function to list files in a directory
list_files() {
    echo -n "Enter the directory to list files: "
    read directory
    if [ -d "$directory" ]; then
        ls -l "$directory"
    else
        echo "Directory '$directory' not found."
    fi
}

# Function to create a directory
create_directory() {
    echo -n "Enter the directory name to create: "
    read directory
    mkdir -p "$directory"
    echo "Directory '$directory' created."
}

# Function to delete a directory
delete_directory() {
    echo -n "Enter the directory name to delete: "
    read directory
    if [ -d "$directory" ]; then
        rmdir "$directory"
        echo "Directory '$directory' deleted."
    else
        echo "Directory '$directory' not found or not empty."
    fi
}

# Function to copy a file
copy_file() {
    echo -n "Enter the filename to copy: "
    read filename
    if [ -f "$filename" ]; then
        echo -n "Enter the destination directory: "
        read dest
        if [ -d "$dest" ]; then
            cp "$filename" "$dest"
            echo "File '$filename' copied to '$dest'."
        else
            echo "Directory '$dest' not found."
        fi
    else
        echo "File '$filename' not found."
    fi
}

# Function to rename a file or directory
rename_file_or_directory() {
    echo -n "Enter the current name: "
    read current_name
    if [ -e "$current_name" ]; then
        echo -n "Enter the new name: "
        read new_name
        mv "$current_name" "$new_name"
        echo "'$current_name' renamed to '$new_name'."
    else
        echo "'$current_name' not found."
    fi
}

# Function to search for files
search_files() {
    echo -n "Enter the directory to search in: "
    read directory
    if [ -d "$directory" ]; then
        echo -n "Enter the filename pattern to search for: "
        read pattern
        find "$directory" -name "$pattern"
    else
        echo "Directory '$directory' not found."
    fi
}

clear_display(){
   clear 
}

# Main loop
while true; do
    display_menu
    read choice
    case $choice in
        1) create_file ;;
        2) delete_file ;;
        3) move_file ;;
        4) list_files ;;
        5) create_directory ;;
        6) delete_directory ;;
        7) copy_file ;;
        8) rename_file_or_directory ;;
        9) search_files ;;
        10) echo "Exiting..."; exit 0 ;;
        11) clear_display ;;
        *) echo "Invalid option, please select a valid option." ;;
    esac
    echo
done