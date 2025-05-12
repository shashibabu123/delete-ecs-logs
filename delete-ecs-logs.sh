#!/bin/bash

# Set your region
REGION="us-east-1"

# List all ECS log groups (optional filter: prefix "/ecs/")
LOG_GROUPS=$(aws logs describe-log-groups \
  --log-group-name-prefix "/ecs/" \
  --region "$REGION" \
  --query "logGroups[*].logGroupName" \
  --output text)

# Loop through each log group and delete it
for LOG_GROUP in $LOG_GROUPS; do
  echo "Deleting log group: $LOG_GROUP"
  aws logs delete-log-group --log-group-name "$LOG_GROUP" --region "$REGION"
done

echo "All ECS log groups deleted."

