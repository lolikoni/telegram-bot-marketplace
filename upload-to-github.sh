#!/bin/bash

echo "🚀 Upload to GitHub Script"
echo "=========================="

# Проверяем статус Git
echo "📋 Checking Git status..."
git status

# Добавляем все файлы
echo "📦 Adding files to Git..."
git add .

# Делаем commit
echo "💾 Creating commit..."
git commit -m "Initial commit - Telegram Bot for marketplace"

# Пытаемся загрузить
echo "📤 Pushing to GitHub..."
echo "⚠️  If this fails, use one of the manual methods from MANUAL_UPLOAD.md"
git push -u origin main

if [ $? -eq 0 ]; then
    echo "✅ Success! Code uploaded to GitHub"
    echo "🔗 Repository: https://github.com/lolikoni/telegram-bot-marketplace"
    echo ""
    echo "🎯 Next steps:"
    echo "1. Go to https://render.com"
    echo "2. Create new Web Service"
    echo "3. Connect GitHub repository"
    echo "4. Follow DEPLOY_STEPS.md"
else
    echo "❌ Push failed. Try manual methods:"
    echo "📖 See MANUAL_UPLOAD.md for alternatives"
fi 