# Git Submodule - Szybki Start

## Co to jest?

Folder `android/` jest teraz **Git Submodule** wskazujący na osobne repozytorium:
- **Główne repo**: https://github.com/fizzyappkm-bit/ionic.git (Vue/TypeScript)
- **Android repo**: https://github.com/fizzyappkm-bit/ionic-android.git (Kotlin)

## Klonowanie Projektu

### Pierwszy Raz
```bash
git clone --recursive https://github.com/fizzyappkm-bit/ionic.git
```

### Jeśli już sklonowane
```bash
git submodule update --init --recursive
```

## Praca z Androidem

### Wejście do folderu Android
```bash
cd android
# Teraz możesz pracować normalnie z git
git status
git pull origin main
```

### Aktualizacja Submodule w Głównym Repo

Po zmianach w repo Android:
```bash
cd android
git pull origin main
cd ..
git add android
git commit -m "Update android submodule"
git push
```

## Migracja Ekranu

1. **W repo Android** - Migruj ekran z Vue na Kotlin
2. **Commit i push** do `ionic-android` repo
3. **W głównym repo** - Zaktualizuj submodule

Szczegóły w `WORKFLOW.md`

## Status

✅ Submodule skonfigurowany
✅ Android repo: https://github.com/fizzyappkm-bit/ionic-android.git
✅ Tab1 zmigrowany do Kotlin

