# 🚀 Production Deployment Guide

## Обзор

Это руководство поможет развернуть Telegram бот для создания карточек товаров на продакшн сервере.

## Требования

### Минимальные требования к серверу:
- **RAM**: 2GB
- **CPU**: 1 ядро
- **Диск**: 20GB SSD
- **ОС**: Ubuntu 20.04/22.04
- **Домен**: (опционально, но рекомендуется)

### Рекомендуемые провайдеры:
- **DigitalOcean** (от $5/месяц)
- **Vultr** (от $2.50/месяц)
- **Linode** (от $5/месяц)
- **AWS EC2** (от $3.50/месяц)

## Пошаговое развертывание

### Шаг 1: Создание сервера

1. **Выберите провайдера** и создайте VPS
2. **Выберите Ubuntu 20.04/22.04**
3. **Выберите план**: 2GB RAM, 1 CPU, 20GB SSD
4. **Настройте SSH ключи** для безопасного доступа
5. **Запишите IP адрес** сервера

### Шаг 2: Подключение к серверу

```bash
ssh root@YOUR_SERVER_IP
```

### Шаг 3: Создание пользователя

```bash
# Создать пользователя
adduser n8n
usermod -aG sudo n8n

# Переключиться на пользователя
su - n8n
```

### Шаг 4: Клонирование проекта

```bash
# Клонировать проект
git clone https://github.com/your-repo/n8n-telegram-bot.git
cd n8n-telegram-bot

# Сделать скрипт исполняемым
chmod +x deploy-production.sh
```

### Шаг 5: Запуск автоматического развертывания

```bash
# Запустить скрипт развертывания
./deploy-production.sh
```

Скрипт автоматически:
- ✅ Установит все зависимости
- ✅ Настроит PostgreSQL базу данных
- ✅ Установит и настроит n8n
- ✅ Настроит Nginx как reverse proxy
- ✅ Настроит SSL сертификат (если указан домен)
- ✅ Настроит firewall
- ✅ Создаст systemd сервис

### Шаг 6: Настройка домена (опционально)

Если у вас есть домен:

1. **Настройте DNS** записи:
   ```
   A    your-domain.com    YOUR_SERVER_IP
   ```

2. **Запустите скрипт с доменом**:
   ```bash
   DOMAIN=your-domain.com SSL_EMAIL=your@email.com ./deploy-production.sh
   ```

### Шаг 7: Доступ к n8n

После развертывания:

1. **Откройте в браузере**: `http://YOUR_SERVER_IP:5678`
2. **Логин**: `admin@example.com`
3. **Пароль**: `Vbmjkl23312`

### Шаг 8: Импорт workflows

1. В n8n перейдите в **"Workflows"**
2. Нажмите **"Import from file"**
3. Импортируйте файлы из папки `workflows/`:
   - `working-telegram-bot.json`
   - `user-management.json`
   - `payment-system.json`
   - `content-generation.json`
   - `image-processing.json`
   - `fraud-protection.json`

### Шаг 9: Настройка Telegram webhook

1. **Получите webhook URL** из n8n
2. **Настройте webhook** в Telegram:
   ```
   https://api.telegram.org/bot8408486346:AAFhB8FKWy6ubIzCCmUfxNXcAceVKTChMWE/setWebhook?url=https://YOUR_DOMAIN/webhook-test/telegram-webhook
   ```

## Управление сервисом

### Команды управления:

```bash
# Запуск
sudo /opt/n8n/start.sh

# Остановка
sudo /opt/n8n/stop.sh

# Перезапуск
sudo /opt/n8n/restart.sh

# Статус
sudo /opt/n8n/status.sh

# Логи
sudo /opt/n8n/logs.sh
```

### Автоматический запуск:

n8n настроен как systemd сервис и будет автоматически запускаться при перезагрузке сервера.

## Безопасность

### Настройки безопасности:
- ✅ Firewall настроен (только SSH, HTTP, HTTPS)
- ✅ n8n работает под отдельным пользователем
- ✅ SSL сертификат (если указан домен)
- ✅ Базовая аутентификация включена

### Рекомендации:
1. **Измените пароль** n8n после первого входа
2. **Обновите encryption key** в `/opt/n8n/.env`
3. **Настройте регулярные бэкапы**
4. **Мониторьте логи** на предмет подозрительной активности

## Мониторинг

### Проверка статуса:

```bash
# Статус n8n
sudo systemctl status n8n

# Статус PostgreSQL
sudo systemctl status postgresql

# Статус Nginx
sudo systemctl status nginx

# Использование ресурсов
htop
```

### Логи:

```bash
# Логи n8n
sudo journalctl -u n8n -f

# Логи Nginx
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Логи PostgreSQL
sudo tail -f /var/log/postgresql/postgresql-*.log
```

## Бэкапы

### Автоматические бэкапы:

```bash
# Создать скрипт бэкапа
sudo tee /opt/n8n/backup.sh > /dev/null <<'EOF'
#!/bin/bash
BACKUP_DIR="/opt/n8n/backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Бэкап базы данных
sudo -u postgres pg_dump n8n > $BACKUP_DIR/n8n_db_$DATE.sql

# Бэкап конфигурации
cp /opt/n8n/.env $BACKUP_DIR/env_$DATE.backup

# Удалить старые бэкапы (старше 7 дней)
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.backup" -mtime +7 -delete

echo "Backup completed: $DATE"
EOF

chmod +x /opt/n8n/backup.sh

# Добавить в cron (ежедневно в 2:00)
(crontab -l 2>/dev/null; echo "0 2 * * * /opt/n8n/backup.sh") | crontab -
```

## Масштабирование

### Для увеличения производительности:

1. **Увеличьте RAM** до 4GB
2. **Добавьте CPU** ядра
3. **Настройте Redis** для кэширования
4. **Используйте CDN** для статических файлов

### Для высокой доступности:

1. **Настройте load balancer**
2. **Используйте несколько серверов**
3. **Настройте автоматическое восстановление**

## Устранение неполадок

### Частые проблемы:

1. **n8n не запускается**:
   ```bash
   sudo systemctl status n8n
   sudo journalctl -u n8n -f
   ```

2. **Проблемы с базой данных**:
   ```bash
   sudo systemctl status postgresql
   sudo -u postgres psql -c "\l"
   ```

3. **Проблемы с Nginx**:
   ```bash
   sudo nginx -t
   sudo systemctl status nginx
   ```

4. **Проблемы с SSL**:
   ```bash
   sudo certbot certificates
   sudo certbot renew --dry-run
   ```

## Поддержка

### Полезные команды:

```bash
# Перезапуск всех сервисов
sudo systemctl restart n8n postgresql nginx

# Проверка портов
sudo netstat -tlnp | grep :5678

# Проверка дискового пространства
df -h

# Проверка использования памяти
free -h
```

### Контакты для поддержки:
- Документация: [docs/](docs/)
- Логи: `/var/log/`
- Конфигурация: `/opt/n8n/` 