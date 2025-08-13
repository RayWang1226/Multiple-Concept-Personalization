#!/bin/bash

# Ensure the script stops on error
set -e

# URL and filename
FILE_ID="1ekSW4A3bBe9yijKfUdPHdN73Yy65CG5w"
OUTPUT_FILE="dataset.zip"

# Download the ZIP file using gdown
echo "Downloading dataset..."
gdown "https://drive.google.com/uc?id=${FILE_ID}" -O "$OUTPUT_FILE"

# Unzip the downloaded file
echo "Unzipping dataset..."
unzip -q "$OUTPUT_FILE"

# Remove the ZIP file
echo "Cleaning up..."
rm "$OUTPUT_FILE"

echo "Dataset downloaded and extracted successfully."
