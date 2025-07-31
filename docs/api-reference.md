# API Reference

## Общая информация

### Базовый URL
```
http://localhost:5678/webhook/
```

### Аутентификация
Большинство endpoints требуют JWT токен в заголовке Authorization:
```
Authorization: Bearer <your-jwt-token>
```

### Формат ответов
Все ответы возвращаются в формате JSON:

```json
{
  "status": "success|error",
  "message": "Описание результата",
  "data": { /* данные ответа */ }
}
```

## Telegram Bot API

### Webhook Endpoint

#### POST /telegram-webhook
Получает обновления от Telegram Bot API.

**Тело запроса:**
```json
{
  "update_id": 123456789,
  "message": {
    "message_id": 1,
    "from": {
      "id": 123456789,
      "first_name": "Иван",
      "last_name": "Иванов",
      "username": "ivan_ivanov"
    },
    "chat": {
      "id": 123456789,
      "type": "private"
    },
    "date": 1640995200,
    "text": "/start"
  }
}
```

**Ответ:**
```json
{
  "status": "ok",
  "message": "Webhook processed successfully"
}
```

## User Management API

### Регистрация пользователя

#### POST /user-register
Регистрирует нового пользователя в системе.

**Тело запроса:**
```json
{
  "email": "user@example.com",
  "password": "secure_password",
  "firstName": "Иван",
  "lastName": "Иванов",
  "telegramId": 123456789
}
```

**Ответ (успех):**
```json
{
  "status": "success",
  "message": "User registered successfully",
  "userId": "user_123"
}
```

**Ответ (ошибка):**
```json
{
  "status": "error",
  "message": "Invalid registration data"
}
```

### Авторизация пользователя

#### POST /user-login
Авторизует пользователя и возвращает JWT токен.

**Тело запроса:**
```json
{
  "email": "user@example.com",
  "password": "secure_password"
}
```

**Ответ (успех):**
```json
{
  "status": "success",
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Ответ (ошибка):**
```json
{
  "status": "error",
  "message": "Invalid credentials"
}
```

### Профиль пользователя

#### GET /user-profile
Получает информацию о профиле пользователя.

**Заголовки:**
```
Authorization: Bearer <jwt-token>
```

**Ответ (успех):**
```json
{
  "status": "success",
  "user": {
    "id": "user_123",
    "email": "user@example.com",
    "firstName": "Иван",
    "lastName": "Иванов",
    "plan": "basic",
    "balance": 5,
    "createdAt": "2024-01-01T00:00:00.000Z"
  }
}
```

**Ответ (ошибка):**
```json
{
  "status": "error",
  "message": "Invalid authentication token"
}
```

## Payment System API

### Создание платежа

#### POST /create-payment
Создает новый платеж для пользователя.

**Тело запроса:**
```json
{
  "userId": "user_123",
  "plan": "basic",
  "amount": 500,
  "paymentProvider": "stripe"
}
```

**Ответ (успех):**
```json
{
  "status": "success",
  "paymentUrl": "https://checkout.stripe.com/pay/cs_test_..."
}
```

**Ответ (ошибка):**
```json
{
  "status": "error",
  "message": "Invalid payment data"
}
```

### Webhook платежей

#### POST /payment-webhook
Получает уведомления о статусе платежей от платежных систем.

**Тело запроса (Stripe):**
```json
{
  "id": "evt_123456789",
  "type": "payment_intent.succeeded",
  "data": {
    "object": {
      "id": "pi_123456789",
      "amount": 50000,
      "currency": "rub",
      "status": "succeeded",
      "metadata": {
        "user_id": "user_123",
        "plan": "basic"
      }
    }
  }
}
```

**Ответ:**
```json
{
  "status": "success",
  "message": "Payment processed successfully"
}
```

### История платежей

#### GET /payment-history
Получает историю платежей пользователя.

**Заголовки:**
```
Authorization: Bearer <jwt-token>
```

**Параметры запроса:**
- `userId` (обязательный) - ID пользователя
- `limit` (опциональный) - количество записей (по умолчанию 10)
- `offset` (опциональный) - смещение (по умолчанию 0)

**Ответ (успех):**
```json
{
  "status": "success",
  "payments": [
    {
      "id": "payment_123",
      "userId": "user_123",
      "amount": 500,
      "plan": "basic",
      "status": "completed",
      "provider": "stripe",
      "createdAt": "2024-01-01T00:00:00.000Z"
    }
  ]
}
```

## Content Generation API

### Генерация контента

#### POST /generate-content
Генерирует контент для карточки товара с помощью ИИ.

**Тело запроса:**
```json
{
  "userId": "user_123",
  "productName": "Смартфон iPhone 15",
  "category": "Электроника",
  "characteristics": "6.1 дюйм, 128 ГБ, черный",
  "price": 89990
}
```

**Ответ (успех):**
```json
{
  "status": "success",
  "content": {
    "description": "{\"title\":\"iPhone 15 - Инновации в каждой детали\",\"description\":\"Откройте для себя новый iPhone 15...\",\"features\":[\"6.1-дюймовый дисплей\",\"128 ГБ памяти\"],\"benefits\":[\"Мощный процессор\",\"Отличная камера\"],\"callToAction\":\"Заказать сейчас\"}",
    "colorScheme": "{\"primaryColor\":\"#007AFF\",\"secondaryColor\":\"#5856D6\",\"accentColor\":\"#FF3B30\",\"backgroundColor\":\"#FFFFFF\",\"textColor\":\"#000000\"}",
    "seoContent": "{\"keywords\":[\"iPhone 15\",\"смартфон\",\"Apple\"],\"tags\":[\"электроника\",\"смартфон\",\"Apple\"],\"metaTitle\":\"iPhone 15 - Купить в России\",\"metaDescription\":\"Купите iPhone 15 по лучшей цене...\"}",
    "imageUrl": "https://example.com/generated-image.jpg",
    "contentId": "content_123"
  }
}
```

**Ответ (ошибка):**
```json
{
  "status": "error",
  "message": "Insufficient balance. Please top up your account."
}
```

## Image Processing API

### Обработка изображений

#### POST /process-image
Обрабатывает и улучшает изображения товаров.

**Тело запроса:**
```json
{
  "userId": "user_123",
  "imageUrl": "https://example.com/product-image.jpg"
}
```

**Ответ (успех):**
```json
{
  "status": "success",
  "enhancedImageUrl": "https://example.com/enhanced-image.jpg",
  "thumbnailUrl": "https://example.com/thumbnail.jpg"
}
```

**Ответ (ошибка):**
```json
{
  "status": "error",
  "message": "Invalid image URL"
}
```

## Fraud Protection API

### Проверка на мошенничество

#### POST /fraud-check
Проверяет активность пользователя на подозрительность.

**Тело запроса:**
```json
{
  "userId": "user_123",
  "ipAddress": "192.168.1.1",
  "action": "payment_attempt"
}
```

**Ответ (разрешено):**
```json
{
  "status": "allowed",
  "message": "Activity check passed",
  "riskScore": 0
}
```

**Ответ (заблокировано):**
```json
{
  "status": "blocked",
  "message": "User blocked due to suspicious activity",
  "riskScore": 85
}
```

## Коды ошибок

### Общие ошибки

| Код | Описание |
|-----|----------|
| 400 | Bad Request - Неверный формат запроса |
| 401 | Unauthorized - Неверный токен авторизации |
| 403 | Forbidden - Недостаточно прав |
| 404 | Not Found - Ресурс не найден |
| 429 | Too Many Requests - Превышен лимит запросов |
| 500 | Internal Server Error - Внутренняя ошибка сервера |

### Специфичные ошибки

| Код | Описание |
|-----|----------|
| 1001 | Insufficient balance - Недостаточно средств |
| 1002 | Invalid payment data - Неверные данные платежа |
| 1003 | Payment failed - Ошибка платежа |
| 2001 | User not found - Пользователь не найден |
| 2002 | Invalid credentials - Неверные учетные данные |
| 3001 | Content generation failed - Ошибка генерации контента |
| 3002 | AI service unavailable - ИИ-сервис недоступен |
| 4001 | Image processing failed - Ошибка обработки изображения |
| 5001 | Suspicious activity detected - Обнаружена подозрительная активность |

## Rate Limiting

### Лимиты запросов

| Endpoint | Лимит | Период |
|----------|-------|--------|
| /user-register | 5 | 1 час |
| /user-login | 10 | 1 час |
| /generate-content | 20 | 1 час |
| /process-image | 10 | 1 час |
| /create-payment | 5 | 1 час |

### Заголовки rate limiting

```
X-RateLimit-Limit: 20
X-RateLimit-Remaining: 15
X-RateLimit-Reset: 1640995200
```

## Webhook Events

### Telegram Events

| Событие | Описание |
|---------|----------|
| message | Новое сообщение |
| edited_message | Отредактированное сообщение |
| channel_post | Пост в канале |
| callback_query | Нажатие inline кнопки |

### Payment Events

| Событие | Описание |
|---------|----------|
| payment_intent.succeeded | Платеж успешно завершен |
| payment_intent.payment_failed | Платеж не удался |
| invoice.payment_succeeded | Инвойс оплачен |
| invoice.payment_failed | Инвойс не оплачен |

## Примеры использования

### Полный цикл создания карточки товара

```bash
# 1. Регистрация пользователя
curl -X POST "http://localhost:5678/webhook/user-register" \
     -H "Content-Type: application/json" \
     -d '{
       "email": "user@example.com",
       "password": "password123",
       "firstName": "Иван",
       "lastName": "Иванов"
     }'

# 2. Авторизация
curl -X POST "http://localhost:5678/webhook/user-login" \
     -H "Content-Type: application/json" \
     -d '{
       "email": "user@example.com",
       "password": "password123"
     }'

# 3. Создание платежа
curl -X POST "http://localhost:5678/webhook/create-payment" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer <jwt-token>" \
     -d '{
       "userId": "user_123",
       "plan": "basic",
       "amount": 500
     }'

# 4. Генерация контента
curl -X POST "http://localhost:5678/webhook/generate-content" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer <jwt-token>" \
     -d '{
       "userId": "user_123",
       "productName": "Смартфон iPhone 15",
       "category": "Электроника",
       "characteristics": "6.1 дюйм, 128 ГБ",
       "price": 89990
     }'

# 5. Обработка изображения
curl -X POST "http://localhost:5678/webhook/process-image" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer <jwt-token>" \
     -d '{
       "userId": "user_123",
       "imageUrl": "https://example.com/product-image.jpg"
     }'
```

### Обработка ошибок

```javascript
async function makeRequest(endpoint, data) {
  try {
    const response = await fetch(`http://localhost:5678/webhook/${endpoint}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify(data)
    });

    const result = await response.json();

    if (result.status === 'error') {
      throw new Error(result.message);
    }

    return result;
  } catch (error) {
    console.error('Request failed:', error.message);
    throw error;
  }
}
```

## SDK и библиотеки

### JavaScript/Node.js

```javascript
class TelegramBotAPI {
  constructor(baseUrl, token) {
    this.baseUrl = baseUrl;
    this.token = token;
  }

  async generateContent(productData) {
    return this.makeRequest('generate-content', productData);
  }

  async processImage(imageUrl) {
    return this.makeRequest('process-image', { imageUrl });
  }

  async makeRequest(endpoint, data) {
    // Реализация запроса
  }
}
```

### Python

```python
import requests

class TelegramBotAPI:
    def __init__(self, base_url, token):
        self.base_url = base_url
        self.token = token
    
    def generate_content(self, product_data):
        return self.make_request('generate-content', product_data)
    
    def process_image(self, image_url):
        return self.make_request('process-image', {'imageUrl': image_url})
    
    def make_request(self, endpoint, data):
        # Реализация запроса
        pass
```

## Версионирование API

### Текущая версия
- **Версия**: v1
- **Статус**: Стабильная
- **Дата релиза**: 2024-01-01

### Планы на будущее
- **v2**: Добавление новых ИИ-моделей
- **v3**: Интеграция с маркетплейсами
- **v4**: Расширенная аналитика

### Обратная совместимость
API v1 будет поддерживаться минимум 12 месяцев после релиза v2. 