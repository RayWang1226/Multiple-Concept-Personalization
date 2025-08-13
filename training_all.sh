#!/bin/bash

# Define associative array for Foldername
declare -A Foldername=( 
  ["cat2"]="cat" 
  ["dog"]="dog" 
  ["dog6"]="dog" 
  ["flower_1"]="flower" 
  ["pet_cat1"]="pet_cat" 
  ["vase"]="vase" 
  ["watercolor"]="watercolor"
  ["wearable_glasses"]="wearable_glasses"
)

# Loop through all instances in the Foldername array
for INSTANCE_NAME in "${!Foldername[@]}"; do
  INSTANCE_PROMPT="${Foldername[$INSTANCE_NAME]}"
  export MODEL_NAME="stabilityai/stable-diffusion-2-1" 
  export INSTANCE_DIR="./Data/concept_image/${INSTANCE_NAME}"
  export OUTPUT_DIR="My_residuals/${INSTANCE_NAME}"

  echo "Starting training for instance: $INSTANCE_NAME"
  echo "Using instance prompt: $INSTANCE_PROMPT"
  echo "============================================================"

  # Run training with accelerate
  accelerate launch train_cones2.py \
    --pretrained_model_name_or_path=$MODEL_NAME \
    --instance_data_dir=$INSTANCE_DIR \
    --instance_prompt="$INSTANCE_PROMPT" \
    --token_num=1 \
    --output_dir=$OUTPUT_DIR \
    --resolution=768 \
    --train_batch_size=1 \
    --gradient_accumulation_steps=3 \
    --learning_rate=5e-6 \
    --lr_scheduler="constant" \
    --lr_warmup_steps=0 \
    --max_train_steps=5000 \
    --loss_rate_first=1e-2 \
    --loss_rate_second=1e-3

  echo "Completed training for instance: $INSTANCE_NAME"
  echo "============================================================"
done
