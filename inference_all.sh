#!/bin/bash

# Model name
export MODEL_NAME="stabilityai/stable-diffusion-2-1"

# List of JSON configuration files
CONFIG_FILES=("guidance_config_prompt0.json" "guidance_config_prompt1.json" "guidance_config_prompt2.json" "guidance_config_prompt3.json")

# Indices of files to skip (1-based indexing for user readability)
SKIP_CONFIG_INDICES=()

# Function to check if an element is in an array
is_in_array() {
    local element=$1
    shift
    for i in "$@"; do
        if [[ "$i" -eq "$element" ]]; then
            return 0
        fi
    done
    return 1
}

# Run inference.py for each configuration file
for INDEX in "${!CONFIG_FILES[@]}"; do
    CONFIG=${CONFIG_FILES[$INDEX]}
    INDEX_PLUS_ONE=$((INDEX + 1)) # Adjust to 1-based indexing

    # Check if this index should be skipped
    if is_in_array "$INDEX_PLUS_ONE" "${SKIP_CONFIG_INDICES[@]}"; then
        echo "Skipping inference for configuration: $CONFIG"
        continue
    fi

    echo "Running inference with configuration: $CONFIG"
    python inference.py --pretrained_model_name_or_path $MODEL_NAME --inference_config "$CONFIG"
    if [ $? -ne 0 ]; then
        echo "Error running inference with $CONFIG. Exiting..."
        exit 1
    fi
    echo "Finished inference with configuration: $CONFIG"
done

echo "All inferences completed successfully!"
