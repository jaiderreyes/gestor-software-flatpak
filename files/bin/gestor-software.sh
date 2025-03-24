#!/bin/bash

# Verifica si fzf y yay están instalados
for cmd in fzf yay; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Instalando dependencia: $cmd"
    sudo pacman -S "$cmd" --noconfirm
  fi
done

# Menú principal
action=$(printf "🔍 Buscar e instalar\n📂 Buscar por categoría\n📄 Ver changelog\n🗑️ Desinstalar\n❌ Salir" | fzf --prompt="Selecciona acción: ")

case "$action" in
  "🔍 Buscar e instalar")
    pkg=$(yay -Ss "" | awk '{print $1}' | sort -u | fzf --prompt="Buscar paquete: " --preview="yay -Si {}" --height=40%)
    [ -n "$pkg" ] && yay -S "$pkg"
    ;;
  "📂 Buscar por categoría")
    group=$(yay -Slq | xargs pacman -Si | awk -F': ' '/^Groups/ {print $2}' | tr ' ' '\n' | sort -u | fzf --prompt="Grupo: ")
    [ -n "$group" ] && yay -Sg "$group" | fzf --multi --preview="yay -Si {}" | xargs -r yay -S
    ;;
  "📄 Ver changelog")
    pkg=$(pacman -Qq | fzf --prompt="Selecciona paquete: ")
    [ -n "$pkg" ] && yay -Si "$pkg" | less
    ;;
  "🗑️ Desinstalar")
    pkg=$(pacman -Qq | fzf --multi --prompt="Selecciona para desinstalar: ")
    [ -n "$pkg" ] && sudo pacman -Rns $pkg
    ;;
  *)
    echo "Saliendo..."
    ;;
esac
