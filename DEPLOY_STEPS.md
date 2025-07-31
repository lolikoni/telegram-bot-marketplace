# 🚀 Пошаговое развертывание на Render

## Шаг 1: Создание GitHub репозитория

1. Перейдите на https://github.com/new
2. Создайте репозиторий:
   - **Repository name:** `telegram-bot-marketplace`
   - **Description:** `🤖 Telegram Bot для создания карточек товаров с AI`
   - **Visibility:** Public
   - НЕ ставьте галочки (README, .gitignore, license)
3. Нажмите "Create repository"

## Шаг 2: Загрузка кода

Замените `YOUR_USERNAME` на ваше имя пользователя GitHub и выполните:

```bash
# Замените YOUR_USERNAME на ваше имя пользователя
git remote set-url origin https://github.com/YOUR_USERNAME/telegram-bot-marketplace.git
git push -u origin main
```

## Шаг 3: Развертывание на Render

1. **Перейдите на Render:** https://render.com
2. **Зарегистрируйтесь/войдите** в аккаунт
3. **Создайте новый Web Service:**
   - Нажмите "New +" → "Web Service"
   - Подключите GitHub репозиторий
   - Выберите `telegram-bot-marketplace`

## Шаг 4: Настройка Render

### Основные настройки:
- **Name:** `telegram-bot-marketplace`
- **Environment:** `Node`
- **Region:** Выберите ближайший к вам
- **Branch:** `main`
- **Build Command:** `npm install`
- **Start Command:** `n8n start`

### Переменные окружения (Environment Variables):

Добавьте следующие переменные в Render:

| Ключ | Значение |
|------|----------|
| `N8N_PORT` | `3000` |
| `N8N_PROTOCOL` | `https` |
| `N8N_HOST` | `0.0.0.0` |
| `N8N_USER_MANAGEMENT_DISABLED` | `false` |
| `N8N_BASIC_AUTH_ACTIVE` | `true` |
| `N8N_BASIC_AUTH_USER` | `admin@example.com` |
| `N8N_BASIC_AUTH_PASSWORD` | `Vbmjkl23312` |
| `N8N_ENCRYPTION_KEY` | `your-secret-encryption-key-here` |
| `TELEGRAM_BOT_TOKEN` | `your_telegram_bot_token` |
| `OPENAI_API_KEY` | `your_openai_api_key` |
| `REPLICATE_API_TOKEN` | `your_replicate_api_token` |
| `STRIPE_SECRET_KEY` | `your_stripe_secret_key` |
| `N8N_SECURITY_OAUTH2_DISABLED` | `true` |
| `N8N_LOG_LEVEL` | `info` |
| `N8N_DIAGNOSTICS_ENABLED` | `false` |

## Шаг 5: Запуск развертывания

1. Нажмите "Create Web Service"
2. Дождитесь завершения развертывания (5-10 минут)
3. Скопируйте URL вашего сервиса (например: `https://telegram-bot-marketplace.onrender.com`)

## Шаг 6: Настройка Telegram Webhook

1. Откройте n8n по адресу: `https://your-app-name.onrender.com`
2. Войдите с учетными данными: `admin@example.com` / `Vbmjkl23312`
3. Импортируйте workflows из папки `workflows/`
4. Настройте Telegram webhook:
   ```
   https://your-app-name.onrender.com/webhook/telegram-webhook
   ```

## Шаг 7: Тестирование

1. Найдите вашего бота в Telegram
2. Отправьте команду `/start`
3. Проверьте работу всех функций

## 🎯 Готово!

Ваш Telegram бот теперь работает на Render и доступен 24/7!

---

**Проблемы?** Проверьте логи в Render Dashboard или обратитесь к документации. 