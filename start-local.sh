#!/bin/bash

# Local development startup script for iRedMail Docker

echo "Starting iRedMail Docker container for local development..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker first."
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null 2>&1; then
    echo "Error: docker-compose is not installed."
    exit 1
fi

# Check if configuration file exists
if [ ! -f "iredmail-docker.conf" ]; then
    echo "Error: iredmail-docker.conf not found. Please create it first."
    exit 1
fi

# Create data directories if they don't exist
echo "Creating data directories..."
mkdir -p data/{backup-mysql,clamav,custom,imapsieve_copy,mailboxes,mlmmj,mlmmj-archive,mysql,sa_rules,ssl,postfix_queue}

# Start the container using docker-compose
echo "Starting iRedMail container..."
if command -v docker-compose &> /dev/null; then
    docker-compose up -d
else
    docker compose up -d
fi

# Check if container started successfully
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ iRedMail container started successfully!"
    echo ""
    echo "📧 Access points:"
    echo "   - Webmail (Roundcube): https://localhost"
    echo "   - Admin Panel: https://localhost/iredadmin"
    echo "   - Mail server: mail.local.test"
    echo ""
    echo "🔑 Credentials:"
    echo "   - Admin email: postmaster@local.test"
    echo "   - Admin password: SecurePassword123!"
    echo ""
    echo "📝 Notes:"
    echo "   - First startup may take several minutes to initialize databases"
    echo "   - The container will download ClamAV and SpamAssassin updates"
    echo "   - SSL certificate is self-signed, you'll need to accept it in browser"
    echo ""
    echo "🛑 To stop: docker-compose down"
    echo "📊 To view logs: docker-compose logs -f"
    echo "🔍 To check status: docker-compose ps"
else
    echo "❌ Failed to start iRedMail container. Check the logs with: docker-compose logs"
    exit 1
fi
