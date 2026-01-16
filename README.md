# Ionic App - Stopniowa Migracja na Android Native

## Przegląd

Ten projekt zawiera aplikację Ionic Vue/TypeScript, która jest stopniowo migrowana na natywny Android Kotlin. 

**Ważne**: Kod Android jest zarządzany w osobnym repozytorium jako Git Submodule. W tym repozytorium **NIE DODAJEMY** zmian dla Androida - tylko zaciągamy je z zewnętrznego repo i budujemy wersje.

## Struktura Projektu

```
ionic-app/ (główne repo)
├── src/                    # Vue/TypeScript - główny kod aplikacji
│   └── views/
│       ├── Tab1.vue
│       ├── Tab2.vue
│       └── Tab3.vue
├── android/                # Git Submodule → ionic-android repo
│   ├── app/src/main/kotlin/  # Kod Kotlin (NIE EDYTOWAĆ tutaj!)
│   └── ionic-source/        # Submodule w submodule → pliki Vue jako referencja
│       └── src/views/       # Pliki Vue używane do migracji
├── www/                    # Zbudowane pliki web
└── package.json           # Zależności Vue/Ionic
```

**Architektura:**
- **ionic-app** (to repo) - zawiera kod Vue/TypeScript
- **ionic-app/android** (submodule) - zawiera kod Kotlin
- **ionic-app/android/ionic-source** (submodule w submodule) - zawiera pliki Vue jako referencję do migracji

## Repozytoria

- **Główne repo (to repo)**: Kod Vue/TypeScript/Ionic
- **Android repo (submodule)**: https://github.com/fizzyappkm-bit/ionic-android.git
  - Wszystkie zmiany dla Androida są robione w tym repo
  - W głównym repo tylko zaciągamy zmiany przez submodule

## Szybki Start

### Klonowanie Projektu (Pierwszy Raz)

```bash
git clone --recursive https://github.com/your-org/ionic-app.git
cd ionic-app
npm install
```

### Jeśli Projekt Już Sklonowany

```bash
git submodule update --init --recursive
npm install
```

## Workflow Pracy

### 1. Praca nad Vue/TypeScript (Główne Repo)

```bash
# W głównym katalogu projektu
git checkout -b feature/new-feature
# Rozwijasz funkcjonalność w Vue
git add src/
git commit -m "Add new feature in Vue"
git push origin feature/new-feature
```

### 2. Zaciąganie Zmian z Repo Android

Gdy w repo Android pojawią się nowe zmiany (np. zmigrowany ekran):

```bash
# Zaktualizuj submodule do najnowszej wersji
cd android
git pull origin main
cd ..

# Zaktualizuj referencję submodule w głównym repo
git add android
git commit -m "Update android submodule: [opis zmian]"
git push
```

### 3. Budowanie Aplikacji

```bash
# Zbuduj aplikację web
npm run build

# Zsynchronizuj z Capacitor
npx cap sync android

# Otwórz w Android Studio
npx cap open android
```

## ⚠️ WAŻNE: Nie Edytuj Kodu Android w Tym Repo!

**W tym repozytorium NIE DODAJEMY zmian dla Androida.**

Wszystkie zmiany dla Androida są robione w osobnym repo:
- https://github.com/fizzyappkm-bit/ionic-android.git

**Jak to działa:**
1. W repo `ionic-android` masz dostęp do plików Vue przez submodule `ionic-source/`
2. Pliki Vue służą jako **referencja** podczas migracji ekranów na Kotlin
3. Stopniowo podmieniasz ekrany Vue na natywne ekrany Kotlin w repo `ionic-android`

**Jeśli chcesz zmienić kod Android:**
1. Przejdź do folderu `android/` (submodule)
2. Wprowadź zmiany w kodzie Kotlin
3. Użyj plików z `android/ionic-source/` jako referencji do migracji
4. Commit i push do repo `ionic-android`
5. Wróć do głównego repo i zaktualizuj submodule (patrz sekcja wyżej)

## Skrypty Pomocnicze

Użyj skryptów pomocniczych do zarządzania submodułem:

```bash
# Zaktualizuj submodule do najnowszej wersji
./scripts/update-android.sh

# Sprawdź status submodułu
./scripts/check-android-status.sh
```

## Dokumentacja

- [WORKFLOW.md](./WORKFLOW.md) - Szczegółowy workflow synchronizacji
- [SYNC_STRATEGY.md](./SYNC_STRATEGY.md) - Strategia synchronizacji
- [MIGRATION_PLAN.md](./MIGRATION_PLAN.md) - Plan migracji ekranów
- [README_SUBMODULE.md](./README_SUBMODULE.md) - Szybki start submodułu

## Status Migracji

✅ **Tab1** - Zmigrowany do Kotlin  
⏳ **Tab2** - Do migracji  
⏳ **Tab3** - Do migracji  

Szczegóły w [MIGRATION_PLAN.md](./MIGRATION_PLAN.md)

## Rozwiązywanie Problemów

### Submodule nie jest zainicjalizowany

```bash
git submodule update --init --recursive
```

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

## Zależności

- Node.js 18+
- npm/yarn
- Capacitor CLI
- Android Studio (dla budowania Android)

