# Workflow Synchronizacji między Repozytoriami

## Struktura

```
ionic (główne repo)
├── src/              # Vue/TypeScript
├── android/          # Git Submodule → ionic-android
└── package.json
```

## Codzienna Praca

### 1. Praca nad Vue (główne repo)

```bash
# W głównym katalogu projektu
git checkout -b feature/new-feature
# Rozwijasz funkcjonalność w Vue
git add src/
git commit -m "Add new feature in Vue"
git push origin feature/new-feature
```

### 2. Migracja Ekranu do Kotlin

```bash
# Przejdź do folderu android (submodule)
cd android

# Pobierz najnowsze zmiany
git pull origin main

# Utwórz branch dla migracji
git checkout -b migrate-tab2

# Migruj ekran (np. Tab2)
# - Utwórz Tab2Fragment.kt
# - Utwórz layout XML
# - Zaktualizuj NativeNavigationHelper

# Commit i push do repo Android
git add .
git commit -m "Migrate Tab2 from Vue to Kotlin"
git push origin migrate-tab2

# Po review, merge do main w repo Android
# (przez GitHub PR lub bezpośrednio)
git checkout main
git pull origin main
```

### 3. Aktualizacja Submodule w Głównym Repo

```bash
# Wróć do głównego katalogu
cd ..

# Zaktualizuj submodule do najnowszej wersji
cd android
git checkout main
git pull origin main
cd ..

# Zaktualizuj referencję submodule w głównym repo
git add android
git commit -m "Update android submodule: Tab2 migration complete"
git push origin main
```

## Przykładowy Scenariusz: Migracja Tab2

### Krok 1: Przygotowanie w Vue
```bash
# W głównym repo
cd /Users/kacperlitwinow/Downloads/ionic-app
# Tab2 jest gotowy do migracji
```

### Krok 2: Migracja do Kotlin
```bash
cd android
git checkout -b migrate-tab2

# Utwórz Tab2Fragment.kt
# Utwórz fragment_tab2.xml
# Zaktualizuj NativeNavigationHelper.kt

git add .
git commit -m "Migrate Tab2 to Kotlin"
git push origin migrate-tab2
```

### Krok 3: Merge i Aktualizacja
```bash
# W repo Android (przez GitHub lub lokalnie)
git checkout main
git merge migrate-tab2
git push origin main

# W głównym repo
cd ..
cd android
git checkout main
git pull origin main
cd ..
git add android
git commit -m "Update android submodule: Tab2 migrated"
git push origin main
```

## Klonowanie Projektu

### Pierwszy Raz
```bash
git clone --recursive https://github.com/fizzyappkm-bit/ionic.git
```

### Jeśli już sklonowane bez --recursive
```bash
git submodule update --init --recursive
```

## Aktualizacja Submodule

### Pobierz najnowsze zmiany
```bash
cd android
git pull origin main
cd ..
git add android
git commit -m "Update android submodule"
```

### Sprawdź wersję submodule
```bash
cd android
git log --oneline -5
cd ..
```

## Rozwiązywanie Problemów

### Submodule wskazuje na stary commit
```bash
cd android
git fetch origin
git checkout main
git pull origin main
cd ..
git add android
git commit -m "Update android submodule"
```

### Konflikt w submodule
```bash
cd android
git pull origin main
# Rozwiąż konflikty
git add .
git commit -m "Resolve conflicts"
git push origin main
cd ..
git add android
git commit -m "Update android submodule after conflict resolution"
```

## Status Migracji

Aktualizuj `MIGRATION_PLAN.md` po każdej migracji:

```markdown
✅ Tab1 - Zmigrowany
✅ Tab2 - Zmigrowany (data: YYYY-MM-DD)
⏳ Tab3 - W trakcie
```

