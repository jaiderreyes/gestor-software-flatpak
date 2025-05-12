#  Gestor de Software (Flatpak)

Una herramienta educativa en consola para sistemas Arch Linux que permite a estudiantes y usuarios avanzados:

- 🔍 Buscar e instalar software desde repositorios y AUR
- 📂 Filtrar por categorías de paquetes
- 📄 Ver changelogs y detalles de instalación
- 🗑️ Desinstalar paquetes de forma interactiva

## Instrucciones de instalación

### 1. Instalar dependencias

```bash
sudo pacman -S flatpak flatpak-builder fzf
flatpak install flathub org.freedesktop.Sdk//23.08 org.freedesktop.Platform//23.08
```

### 2. Compilar e instalar

```bash
flatpak-builder --user --install --force-clean build-dir flatpak-manifest.yml
flatpak run org.jaider.gestorsoftware
```

## 📖 Licencia

Distribuido bajo la licencia [MIT](./LICENSE).
