# 🤖 Telegram Bot для создания карточек товаров

Автоматизированный Telegram бот для создания профессиональных карточек товаров для маркетплейсов с использованием AI.

## ✨ Возможности

- 🤖 **Telegram Bot** - удобный интерфейс в Telegram
- 🎨 **AI генерация** - автоматическое создание описаний и изображений
- 💳 **Платежная система** - интеграция с Telegram Payments и Stripe
- 🔒 **Безопасность** - защита от мошенничества и DDoS
- 📊 **Аналитика** - мониторинг и статистика
- 🔄 **Автоматизация** - полный цикл создания карточек

## 🚀 Быстрое развертывание на Render

### Шаг 1: Клонирование
```bash
git clone https://github.com/your-username/telegram-bot-marketplace.git
cd telegram-bot-marketplace
```

### Шаг 2: Развертывание
```bash
./deploy-render.sh
```

### Шаг 3: Настройка на Render
1. Перейдите на [render.com](https://render.com)
2. Создайте Web Service
3. Подключите GitHub репозиторий
4. Настройте переменные окружения
5. Запустите развертывание

## 📋 Требования

- Node.js 18+
- npm или yarn
- GitHub аккаунт
- Render аккаунт

## 🔧 Технологии

- **n8n** - платформа автоматизации
- **Telegram Bot API** - бот интерфейс
- **OpenAI GPT-4** - генерация текста
- **Replicate** - генерация изображений
- **Stripe** - платежи
- **PostgreSQL** - база данных

## 📁 Структура проекта

```
├── workflows/           # n8n workflows
│   ├── working-telegram-bot.json
│   ├── user-management.json
│   ├── payment-system.json
│   ├── content-generation.json
│   ├── image-processing.json
│   └── fraud-protection.json
├── docs/               # Документация
├── render.yaml         # Render конфигурация
├── deploy-render.sh    # Скрипт развертывания
└── README.md
```

## 🔑 API Ключи

Для работы бота требуются следующие API ключи:

- **Telegram Bot Token** - для работы бота
- **OpenAI API Key** - для генерации текста
- **Replicate API Token** - для генерации изображений
- **Stripe Secret Key** - для платежей

## 📖 Документация

- [Развертывание на Render](RENDER_DEPLOY.md)
- [API Reference](docs/api-reference.md)
- [Production Deployment](docs/production-deployment.md)

## 🤝 Поддержка

Если у вас возникли вопросы или проблемы:

1. Проверьте [документацию](docs/)
2. Посмотрите [логи развертывания](RENDER_DEPLOY.md)
3. Создайте issue в GitHub

## 📄 Лицензия

MIT License - см. файл [LICENSE](LICENSE)

---

**Создано с ❤️ для автоматизации бизнеса** 