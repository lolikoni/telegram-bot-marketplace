# 📤 Ручная загрузка кода в GitHub

## Вариант 1: Через GitHub CLI (рекомендуется)

1. **Авторизуйтесь в GitHub CLI:**
   ```bash
   gh auth login
   ```
   - Выберите "GitHub.com"
   - Выберите "HTTPS"
   - Выберите "Yes" для аутентификации Git
   - Выберите "Login with a web browser"
   - Следуйте инструкциям

2. **Загрузите код:**
   ```bash
   git push -u origin main
   ```

## Вариант 2: Через Personal Access Token

1. **Создайте Personal Access Token:**
   - Перейдите на https://github.com/settings/tokens
   - Нажмите "Generate new token (classic)"
   - Выберите scopes: `repo`, `workflow`
   - Скопируйте токен

2. **Используйте токен:**
   ```bash
   git remote set-url origin https://YOUR_TOKEN@github.com/lolikoni/telegram-bot-marketplace.git
   git push -u origin main
   ```

## Вариант 3: Через GitHub Web Interface

1. **Перейдите в репозиторий:** https://github.com/lolikoni/telegram-bot-marketplace
2. **Нажмите "uploading an existing file"**
3. **Перетащите все файлы из папки проекта**
4. **Добавьте commit message:** "Initial commit - Telegram Bot for marketplace"
5. **Нажмите "Commit changes"**

## Вариант 4: Через GitHub Desktop

1. **Скачайте GitHub Desktop:** https://desktop.github.com/
2. **Клонируйте репозиторий**
3. **Скопируйте все файлы проекта**
4. **Сделайте commit и push**

---

## 🎯 После загрузки кода

1. **Перейдите на Render:** https://render.com
2. **Создайте новый Web Service**
3. **Подключите GitHub репозиторий:** `lolikoni/telegram-bot-marketplace`
4. **Следуйте инструкции в `DEPLOY_STEPS.md`**

---

**Какой вариант вы предпочитаете?** 