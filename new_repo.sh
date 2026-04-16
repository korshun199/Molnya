#!/bin/bash

# --- НАСТРОЙКИ (заполни один раз) ---
TOKEN="ТВОЙ_ТОКЕН_ТУТ"
USER="korshun199"
# ------------------------------------

# Проверка, ввели ли мы имя репозитория
if [ -z "$1" ]
then
    echo "Ошибка: Введи название репозитория!"
    echo "Пример: ./git_init.sh MyProject"
    exit 1
fi

REPO_NAME=$1

echo "🚀 Начинаю магию для проекта: $REPO_NAME"

# 1. Инициализация гит
git init

# 2. Добавляем в исключения safe.directory (чтобы гит не ругался на права доступа)
CURRENT_DIR=$(pwd)
git config --global --add safe.directory "$CURRENT_DIR"

# 3. Добавляем всё и делаем первый коммит
git add .
git commit -m "Начало положено: $REPO_NAME"

# 4. Переименовываем ветку в main
git branch -M main

# 5. Привязываем удаленный репозиторий СРАЗУ С ТОКЕНОМ
# Теперь пароль никогда не потребуется!
git remote add origin "https://$USER:$TOKEN@github.com/$USER/$REPO_NAME.git"

# 6. Пушим (с силой, чтобы пробить начальные файлы на сайте)
echo "📤 Отправляю файлы в облако..."
git push -u origin main --force

echo "✅ Всё готово! Проверяй на гитхабе."