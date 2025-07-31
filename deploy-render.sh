#!/bin/bash

# ========================================
# Render Deployment Script
# ========================================

set -e

echo "🎨 Render Deployment Script"
echo "==========================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if git is initialized
if [ ! -d ".git" ]; then
    print_status "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit"
fi

# Check if remote is set
if ! git remote get-url origin &> /dev/null; then
    print_warning "GitHub remote not set"
    print_status "Please create a GitHub repository and add it as remote:"
    echo "git remote add origin https://github.com/your-username/your-repo.git"
    echo "git push -u origin main"
    exit 1
fi

# Create .env file for local development
print_status "Creating environment file..."
cat > .env <<EOF
# n8n Configuration
N8N_PORT=3000
N8N_PROTOCOL=https
N8N_HOST=0.0.0.0
N8N_USER_MANAGEMENT_DISABLED=false
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin@example.com
N8N_BASIC_AUTH_PASSWORD=Vbmjkl23312
N8N_ENCRYPTION_KEY=your-secure-encryption-key-here

# Telegram Bot
TELEGRAM_BOT_TOKEN=your_telegram_bot_token

# OpenAI
OPENAI_API_KEY=your_openai_api_key

# Replicate
REPLICATE_API_TOKEN=your_replicate_api_token

# Stripe
STRIPE_SECRET_KEY=your_stripe_secret_key

# Security
N8N_SECURITY_OAUTH2_DISABLED=true
N8N_LOG_LEVEL=info
N8N_DIAGNOSTICS_ENABLED=false
EOF

# Commit changes
print_status "Committing changes..."
git add .
git commit -m "Add Render configuration" || true

# Push to GitHub
print_status "Pushing to GitHub..."
git push origin main

print_success "Code pushed to GitHub!"
echo ""
echo "📋 Next steps:"
echo "1. Go to https://render.com"
echo "2. Sign up with GitHub"
echo "3. Click 'New +' → 'Web Service'"
echo "4. Connect your GitHub repository"
echo "5. Configure the service:"
echo "   - Name: telegram-bot-marketplace"
echo "   - Environment: Node"
echo "   - Build Command: npm install"
echo "   - Start Command: n8n start"
echo "6. Add environment variables (see RENDER_DEPLOY.md)"
echo "7. Click 'Create Web Service'"
echo ""
echo "🔧 After deployment:"
echo "1. Copy the Render URL"
echo "2. Configure Telegram webhook with the URL"
echo "3. Import workflows in n8n"
echo ""
print_warning "Don't forget to update the encryption key in Render environment variables" 