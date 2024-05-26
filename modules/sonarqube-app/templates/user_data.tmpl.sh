#!/bin/bash
set -e

# Output all log
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

# Update and install necessary packages
yum update -y
yum install -y docker
service docker start && chkconfig docker on
usermod -a -G docker ec2-user
echo "------ Done Update and Install ------"

# Install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose version
echo "------ Done Install docker-compose ------"

# Create docker-compose environment file
cat <<EOL > /home/ec2-user/.env
DB_HOST=${db_host}
DB_USER=${db_user}
DB_PASSWORD=${db_password}
SONARQUBE_VERSION=${sonarqube_version}
AWS_REGION=${aws_region}
AWS_LOG_GROUP=${aws_log_group}
NAME=${name}
EOL
echo "------ Done Create docker-compose environment file ------"

# Create docker-compose.yml file
cat <<EOL > /home/ec2-user/docker-compose.yml
version: '3.8'

services:
  sonarqube:
    image: sonarqube:\$${SONARQUBE_VERSION}
    ports:
      - "80:9000"
    environment:
      SONARQUBE_JDBC_URL: jdbc:postgresql://\$${DB_HOST}/sonar
      SONARQUBE_JDBC_USERNAME: \$${DB_USER}
      SONARQUBE_JDBC_PASSWORD: \$${DB_PASSWORD}
    logging:
      driver: awslogs
      options:
        awslogs-region: \$${AWS_REGION}
        awslogs-group: \$${AWS_LOG_GROUP}
        awslogs-stream: \$${NAME}
    networks:
      - sonarnet

networks:
  sonarnet:
EOL
chown ec2-user:ec2-user /home/ec2-user/docker-compose.yml
chmod 644 /home/ec2-user/docker-compose.yml
echo "------ Done Create docker-compose.yml file ------"

# Start SonarQube using docker-compose
cd /home/ec2-user
docker-compose up -d
echo "------ Done Start SonarQube using docker-compose ------"
