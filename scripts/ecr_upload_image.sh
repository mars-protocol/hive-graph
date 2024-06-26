#!/bin/bash

set -e
set -o pipefail

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ECR_REGISTRY_URI 

# AWS_ECR_REPOSITORY_NAME

latest_commit=$(git rev-parse HEAD)

# Get the current branch name (optional)
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Generate the Docker image tag by combining the version and the latest commit hash
image_tag="${AWS_ECR_REPOSITORY_NAME}:${current_branch}-${latest_commit}"

sudo docker build --no-cache -t $image_tag .

image_uri="${AWS_ECR_REGISTRY_URI}/${image_tag}"

sudo docker tag $image_tag $image_uri

sudo docker push $image_uri

echo $image_uri
