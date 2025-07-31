# Руководство по установке Telegram-бота

## Предварительные требования

### Системные требования
- Node.js 18+ 
- npm или yarn
- Git
- Доступ к интернету

### Необходимые сервисы
- Telegram Bot Token (от @BotFather)
- OpenAI API ключ
- Replicate API ключ
- База данных (PostgreSQL/SQLite)
- Платежная система (Stripe/Telegram Payments)

## Пошаговая установка

### 1. Клонирование репозитория

```bash
git clone <repository-url>
cd n8n
```

### 2. Установка зависимостей

```bash
npm install
```

### 3. Настройка переменных окружения

```bash
cp env.example .env
```

Отредактируйте файл `.env` и заполните все необходимые переменные:

```env
# Telegram Bot
TELEGRAM_BOT_TOKEN=your_bot_token_here
TELEGRAM_WEBHOOK_URL=your_webhook_url

# OpenAI
OPENAI_API_KEY=your_openai_api_key
OPENAI_MODEL=gpt-4

# Replicate
REPLICATE_API_KEY=your_replicate_api_key

# База данных
DATABASE_URL=your_database_url
DATABASE_API_KEY=your_database_api_key

# Платежная система
STRIPE_SECRET_KEY=your_stripe_secret_key
PAYMENT_PROVIDER_TOKEN=your_payment_provider_token

# Безопасность
JWT_SECRET=your_jwt_secret
ENCRYPTION_KEY=your_encryption_key
```

### 4. Настройка базы данных

#### PostgreSQL (рекомендуется для продакшена)

```sql
CREATE DATABASE telegram_bot_db;
CREATE USER telegram_bot_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE telegram_bot_db TO telegram_bot_user;
```

#### SQLite (для разработки)

База данных будет создана автоматически при первом запуске.

### 5. Создание Telegram бота

1. Откройте Telegram и найдите @BotFather
2. Отправьте команду `/newbot`
3. Следуйте инструкциям для создания бота
4. Сохраните полученный токен в `.env` файл

### 6. Настройка платежной системы

#### Stripe
1. Зарегистрируйтесь на [stripe.com](https://stripe.com)
2. Получите API ключи в панели разработчика
3. Настройте webhook для обработки платежей

#### Telegram Payments
1. Обратитесь к @BotFather для настройки платежей
2. Получите provider token
3. Настройте валюту и лимиты

### 7. Настройка ИИ-сервисов

#### OpenAI
1. Зарегистрируйтесь на [openai.com](https://openai.com)
2. Получите API ключ в настройках аккаунта
3. Добавьте ключ в `.env` файл

#### Replicate
1. Зарегистрируйтесь на [replicate.com](https://replicate.com)
2. Получите API токен в настройках
3. Добавьте токен в `.env` файл

## Запуск системы

### Локальная разработка

```bash
npm run dev
```

Это запустит n8n с туннелем для webhook'ов.

### Продакшн

```bash
npm run build
npm start
```

## Импорт workflows

1. Откройте n8n в браузере (http://localhost:5678)
2. Войдите с учетными данными из `.env`
3. Импортируйте workflows из папки `workflows/`:
   - `telegram-bot-main.json`
   - `user-management.json`
   - `payment-system.json`
   - `content-generation.json`
   - `image-processing.json`
   - `fraud-protection.json`

## Настройка webhook'ов

### Telegram Webhook

После запуска n8n с туннелем:

```bash
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook" \
     -H "Content-Type: application/json" \
     -d '{"url": "https://your-tunnel-url/webhook/telegram-webhook"}'
```

### Stripe Webhook

В панели Stripe добавьте webhook URL:
```
https://your-domain.com/webhook/payment-webhook
```

## Настройка credentials

В n8n создайте следующие credentials:

### Telegram API
- **Name**: Telegram API
- **Type**: HTTP Header Auth
- **Header Name**: Authorization
- **Header Value**: Bearer {{ $env.TELEGRAM_BOT_TOKEN }}

### OpenAI API
- **Name**: OpenAI API
- **Type**: HTTP Header Auth
- **Header Name**: Authorization
- **Header Value**: Bearer {{ $env.OPENAI_API_KEY }}

### Replicate API
- **Name**: Replicate API
- **Type**: HTTP Header Auth
- **Header Name**: Authorization
- **Header Value**: Token {{ $env.REPLICATE_API_KEY }}

### Database API
- **Name**: Database API
- **Type**: HTTP Header Auth
- **Header Name**: Authorization
- **Header Value**: Bearer {{ $env.DATABASE_API_KEY }}

### Stripe API
- **Name**: Stripe API
- **Type**: HTTP Header Auth
- **Header Name**: Authorization
- **Header Value**: Bearer {{ $env.STRIPE_SECRET_KEY }}

## Проверка установки

### 1. Тест Telegram бота

Отправьте команду `/start` вашему боту в Telegram.

### 2. Тест API endpoints

```bash
# Тест регистрации пользователя
curl -X POST "http://localhost:5678/webhook/user-register" \
     -H "Content-Type: application/json" \
     -d '{"email": "test@example.com", "password": "password123", "firstName": "Test"}'

# Тест создания платежа
curl -X POST "http://localhost:5678/webhook/create-payment" \
     -H "Content-Type: application/json" \
     -d '{"userId": "1", "plan": "basic", "amount": 500}'
```

### 3. Проверка логов

Проверьте логи n8n на наличие ошибок:

```bash
tail -f logs/n8n.log
```

## Устранение неполадок

### Проблемы с Telegram ботом

1. **Бот не отвечает**
   - Проверьте правильность токена
   - Убедитесь, что webhook настроен правильно
   - Проверьте логи n8n

2. **Webhook не работает**
   - Убедитесь, что n8n запущен с туннелем
   - Проверьте URL webhook'а
   - Проверьте SSL сертификат (для продакшена)

### Проблемы с ИИ-сервисами

1. **OpenAI API ошибки**
   - Проверьте правильность API ключа
   - Убедитесь, что у вас есть кредиты на счете
   - Проверьте лимиты API

2. **Replicate API ошибки**
   - Проверьте правильность токена
   - Убедитесь, что модель доступна
   - Проверьте лимиты использования

### Проблемы с базой данных

1. **Ошибки подключения**
   - Проверьте правильность URL базы данных
   - Убедитесь, что база данных запущена
   - Проверьте права доступа пользователя

2. **Ошибки миграции**
   - Проверьте схему базы данных
   - Убедитесь, что таблицы созданы
   - Проверьте права на создание таблиц

## Обновление системы

### Обновление n8n

```bash
npm update n8n
```

### Обновление workflows

1. Экспортируйте текущие workflows
2. Импортируйте новые версии
3. Проверьте совместимость

### Обновление переменных окружения

1. Сравните `env.example` с вашим `.env`
2. Добавьте новые переменные
3. Перезапустите систему

## Резервное копирование

### База данных

```bash
# PostgreSQL
pg_dump telegram_bot_db > backup.sql

# SQLite
cp n8n.db backup.db
```

### Workflows

Экспортируйте все workflows через интерфейс n8n.

### Переменные окружения

```bash
cp .env .env.backup
```

## Мониторинг

### Логи

```bash
# Просмотр логов в реальном времени
tail -f logs/n8n.log

# Поиск ошибок
grep "ERROR" logs/n8n.log
```

### Метрики

- Количество активных пользователей
- Время обработки запросов
- Процент успешных транзакций
- Использование ИИ-сервисов

## Безопасность

### Рекомендации

1. Используйте HTTPS в продакшене
2. Регулярно обновляйте зависимости
3. Мониторьте логи на подозрительную активность
4. Используйте сильные пароли
5. Ограничьте доступ к API

### Проверка безопасности

```bash
# Проверка уязвимостей
npm audit

# Обновление зависимостей
npm audit fix
```

## Поддержка

### Полезные ссылки

- [n8n документация](https://docs.n8n.io/)
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [OpenAI API](https://platform.openai.com/docs)
- [Stripe API](https://stripe.com/docs/api)

### Контакты

- Email: support@example.com
- Telegram: @support_bot
- GitHub Issues: [repository-url]/issues 