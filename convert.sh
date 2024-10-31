#!/bin/bash

INPUT_DIR="/data/input"
OUTPUT_DIR="/data/output"

# Function to convert files
convert_files() {
    for file in "$INPUT_DIR"/*; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file")
            output_file="$OUTPUT_DIR/${filename%.*}.qcow2"

            # Check file extension
            case "${filename##*.}" in
                vhd|vhdx|ova)
                    echo "Converting $file to $output_file" >> /var/log/convert.log
                    qemu-img convert -f "${filename##*.}" -O qcow2 "$file" "$output_file"
                    echo "Conversion complete: $output_file" >> /var/log/convert.log
                    ;;
                *)
                    echo "Unsupported file type: $file" >> /var/log/convert.log
                    ;;
            esac
        fi
    done
}

# Run the conversion in a loop
while true; do
    convert_files
    sleep 10 # Wait before checking again
done
