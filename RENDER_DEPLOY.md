# 🎨 Развертывание на Render

## 🚀 Быстрый старт (5 минут)

### Шаг 1: Подготовка проекта

1. **Создайте GitHub репозиторий** и загрузите проект
2. **Или используйте существующий** репозиторий

### Шаг 2: Регистрация на Render

1. Перейдите на [render.com](https://render.com)
2. **Зарегистрируйтесь** через GitHub
3. **Подтвердите email**

### Шаг 3: Создание Web Service

1. **Нажмите "New +"**
2. **Выберите "Web Service"**
3. **Подключите GitHub репозиторий**
4. **Выберите ваш репозиторий**

### Шаг 4: Настройка сервиса

**Основные настройки:**
- **Name**: `telegram-bot-marketplace`
- **Environment**: `Node`
- **Region**: `Oregon (US West)` (или ближайший к вам)
- **Branch**: `main`
- **Build Command**: `npm install`
- **Start Command**: `n8n start`

### Шаг 5: Переменные окружения

В разделе **Environment Variables** добавьте:

```bash
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
TELEGRAM_BOT_TOKEN=8408486346:AAFhB8FKWy6ubIzCCmUfxNXcAceVKTChMWE

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
```

### Шаг 6: Развертывание

1. **Нажмите "Create Web Service"**
2. **Render автоматически развернет** приложение
3. **Дождитесь завершения** (обычно 2-3 минуты)

### Шаг 7: Доступ к n8n

1. **Render предоставит URL** (например: `https://your-app.onrender.com`)
2. **Откройте URL** в браузере
3. **Логин**: `admin@example.com`
4. **Пароль**: `Vbmjkl23312`

### Шаг 8: Импорт workflows

1. В n8n → **Workflows**
2. **Import from file**
3. Импортируйте файлы из папки `workflows/`

### Шаг 9: Настройка Telegram webhook

1. **Скопируйте URL** из Render (например: `https://your-app.onrender.com`)
2. **Настройте webhook**:
   ```
   https://api.telegram.org/botYOUR_BOT_TOKEN/setWebhook?url=https://your-app.onrender.com/webhook-test/telegram-webhook
   ```

## ✅ Готово!

Ваш Telegram бот теперь работает бесплатно на Render!

---

## 🔧 Управление

### Render Dashboard:

- **Overview**: Статус сервиса, URL, логи
- **Logs**: Логи в реальном времени
- **Environment**: Переменные окружения
- **Settings**: Настройки сервиса

### Автоматическое развертывание:

Render автоматически развертывает приложение при каждом push в GitHub!

### Мониторинг:

- **Uptime**: 99.9% доступность
- **Performance**: Мониторинг производительности
- **Logs**: Централизованные логи

## 💰 Стоимость

- **Бесплатно**: 750 часов/месяц
- **Платно**: от $7/месяц (если превысите лимит)

## 🔄 CI/CD

### Автоматическое развертывание:

1. **Push в GitHub** → **Автоматический деплой**
2. **Rollback**: Возврат к предыдущей версии
3. **Preview**: Предварительный просмотр изменений

### Управление версиями:

- **GitHub Integration**: Прямая связь с репозиторием
- **Branch Deployments**: Развертывание из разных веток
- **Manual Deploy**: Ручное развертывание

---

## 🆚 Преимущества Render

### По сравнению с Railway:
- ✅ **Больше бесплатных часов** (750 vs 500)
- ✅ **Лучшая производительность**
- ✅ **Более стабильная работа**
- ✅ **Лучшая поддержка**

### По сравнению с Heroku:
- ✅ **Больше бесплатных часов** (750 vs 550)
- ✅ **Более современная платформа**
- ✅ **Лучшая документация**

---

## 🚨 Важные замечания

### Ограничения бесплатного плана:
- **Sleep mode**: Сервис "засыпает" после 15 минут неактивности
- **Cold start**: Первый запрос может занять 30-60 секунд
- **Bandwidth**: Ограничения на трафик

### Рекомендации:
1. **Используйте webhook ping** для поддержания активности
2. **Настройте мониторинг** uptime
3. **Используйте кэширование** для улучшения производительности

---

**Подробная документация:** [docs/production-deployment.md](docs/production-deployment.md) 