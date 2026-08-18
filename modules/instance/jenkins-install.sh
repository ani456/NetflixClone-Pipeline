#!/bin/bash

set -e   ##stop executing immediately if any command fails.

# Update packages
apt-get update -y
apt-get upgrade -y

# Install Java and required packages
apt-get install -y fontconfig openjdk-21-jre wget

# Create keyrings directory
mkdir -p /etc/apt/keyrings

# Add Jenkins GPG key
wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  > /etc/apt/sources.list.d/jenkins.list

# Install Jenkins
apt-get update -y
apt-get install -y jenkins

# Start Jenkins
systemctl enable jenkins
systemctl start jenkins