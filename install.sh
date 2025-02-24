#!/usr/bin/env bash
# Скрипт для установки (копирования/симлинков) ваших кастомных файлов в AstroNvim.

# 1. Определяем путь до репозитория (где лежит install.sh)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 2. Путь к конфигурации AstroNvim (обычно ~/.config/nvim, но важно уточнить)
#    В AstroNvim lua-файлы обычно лежат в ~/.config/nvim/lua
#    Мы будем считать, что нужно класть в ~/.config/nvim/lua
NVIM_LUA_DIR="$HOME/.config/nvim/lua"

echo "Установка кастомных файлов AstroNvim..."
echo "Репозиторий: $REPO_DIR"
echo "Целевая папка: $NVIM_LUA_DIR"

# --- Вариант A: Создаём симлинки (ln -s), чтобы файлы можно было редактировать напрямую из репо ---
# --- Или Вариант B: Копируем файлы (cp -r), если хотите физически скопировать ---

# Пример cимлинка для папки my_snippets
if [ -d "$REPO_DIR/my_snippets" ]; then
  echo "Симлинк my_snippets -> $NVIM_LUA_DIR/my_snippets"
  ln -sfn "$REPO_DIR/my_snippets" "$NVIM_LUA_DIR/my_snippets"
fi

# Пример для plugins (целиком или выборочно)
if [ -d "$REPO_DIR/plugins" ]; then
  echo "Симлинк plugins -> $NVIM_LUA_DIR/plugins"
  ln -sfn "$REPO_DIR/plugins" "$NVIM_LUA_DIR/plugins"
fi

echo "Установка завершена! Запустите nvim, чтобы проверить."

