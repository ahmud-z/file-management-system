#!/bin/bash

# Function to display menu
display_menu() {
    echo "File Management System"
    echo "1. Create files or directories"
    echo "2. Delete files or directories"
    echo "3. Move files or directories"
    echo "4. List files in a directory"
    echo "9. Rename a file or directory"
    echo "5. Set file permissions"
    echo "8. Copy a file"
    echo "10. Search for files"
    echo "11. Edit File"
    echo "12. Sort File Data"
    echo "13. Change Directory"
    echo "14. Current Directory"
    echo "15. Compress Files"
    echo "16. Unzip Files"
    echo "17. Sort Files"
    echo "18. View File"
    echo "0. Clear Display"
    echo "00. Exit"
    echo -n "Enter your choice [1-18]: "
}

# Function to create a file
create_files_or_directories() {
    echo -n "Do you want to create files or directories? (f/d): "
    read type
    echo -n "Enter the names to create (space-separated): "
    read -a names
    
    if [ "$type" == "f" ]; then
        for name in "${names[@]}"; do
            touch "$name"
            echo "File '$name' created."
        done
        elif [ "$type" == "d" ]; then
        for name in "${names[@]}"; do
            mkdir "$name"
            echo "Directory '$name' created."
        done
    else
        echo "Invalid option. Please enter 'f' for files or 'd' for directories."
    fi
}



# Function to delete a file
delete_files_or_directories() {
    echo -n "Enter the names to delete (space-separated): "
    read -a names
    
    for name in "${names[@]}"; do
        if [ -f "$name" ]; then
            rm "$name"
            echo "File '$name' deleted."
            elif [ -d "$name" ]; then
            rm -r "$name"
            echo "Directory '$name' deleted."
            elif [[ "$name" == *.zip ]]; then
            rm "$name"
            echo "Zip file '$name' deleted."
        else
            echo "File, directory, or zip file '$name' not found."
        fi
    done
}

# Function to move a file
move_files_or_directories() {
    echo -n "Enter the names to move (space-separated): "
    read -a names
    echo -n "Enter the destination directory: "
    read dest
    
    if [ -d "$dest" ]; then
        for name in "${names[@]}"; do
            if [ -e "$name" ]; then
                mv "$name" "$dest"
                echo "'$name' moved to '$dest'."
            else
                echo "'$name' not found."
            fi
        done
    else
        echo "Directory '$dest' not found."
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

# edit files
edit_file() {
    echo -n "Enter the filename to edit: "
    read filename
    
    echo "Choose an editor:"
    echo "1. vim"
    echo "2. nano"
    echo "3. code (VS Code)"
    read editor_choice
    
    case $editor_choice in
        1)
            vim "$filename"
        ;;
        2)
            nano "$filename"
        ;;
        3)
            code "$filename"
        ;;
        *)
            echo "Invalid choice. Please select 1, 2, or 3."
        ;;
    esac
}

# View file
view_file_data() {
    echo -n "Enter your file name: "
    read fileName
    echo -e "File data are displayed below:\n"
    cat "$fileName"
    echo -e "\n"
}

current_directory(){
    echo -n "Your Current Directory is:"
    pwd
}

change_directory(){
    echo -n "Enter a directory: "
    read newDirectory
    cd "$newDirectory"
}

compress_files(){
    echo -n "Enter file names you want to compress (separated by spaces): "
    read -a fileNames
    echo -n "Enter archive name: "
    read zipName
    
    zip -r "$zipName" "${fileNames[@]}"
}


unzip_file() {
    echo -n "Enter the name of the zip file to unzip: "
    read zipFile
    
    echo -n "Enter directory where you want to extract: "
    read extractDir
    
    if [ -z "$extractDir" ]; then
        unzip "$zipFile"
    else
        unzip "$zipFile" -d "$extractDir"
    fi
    
    echo "File unzipped successfully."
}

set_file_permissions() {
    echo -n "Enter the file path for which you want to set permissions: "
    read filePath
    
    echo "Current permissions for $filePath:"
    ls -l "$filePath"
    
    echo -n "Enter the new permissions (e.g., 755): "
    read permissions
    
    chmod "$permissions" "$filePath"
    
    echo "Permissions updated for $filePath:"
    ls -l "$filePath"
}


sort_file_data() {
    echo "Enter a file name you want to sort: "
    read fileName
    echo "Choose sorting criteria:"
    echo "1. Ascending order"
    echo "2. Descending order"
    read choice
    
    case $choice in
        1)
            echo "Sorting files by Ascending order:"
            sort "$fileName"
        ;;
        2)
            echo "Sorting files by Descending order:"
            sort -r "$fileName"
        ;;
        
        *)
            echo "Invalid choice"
        ;;
    esac
}


sort_files() {
    echo "Enter the directory path you want to sort files in: "
    read dirPath
    echo "Choose sorting criteria:"
    echo "1. Name"
    echo "2. Size"
    echo "3. Modification Date"
    read choice
    
    case $choice in
        1)
            echo "Sorting files by name:"
            ls -1 "$dirPath" | sort
        ;;
        2)
            echo "Sorting files by size:"
            ls -lS "$dirPath"
        ;;
        3)
            echo "Sorting files by modification date:"
            ls -lt "$dirPath"
        ;;
        *)
            echo "Invalid choice"
        ;;
    esac
}


# Main loop
while true; do
    display_menu
    read choice
    case $choice in
        1) create_files_or_directories ;;
        2) delete_files_or_directories ;;
        3) move_files_or_directories ;;
        4) list_files ;;
        5) set_file_permissions ;;
        8) copy_file ;;
        9) rename_file_or_directory ;;
        10) search_files ;;
        11) edit_file ;;
        12) sort_file_data ;;
        13) change_directory ;;
        14) current_directory ;;
        15) compress_files ;;
        16) unzip_file ;;
        17) sort_files ;;
        18) view_file_data ;;
        0) clear_display ;;
        00) echo -e "\nSuccessfully Terminated. Thank you.\n"; exit 0 ;;
        *) echo "Invalid option, please select a valid option." ;;
    esac
    echo
done