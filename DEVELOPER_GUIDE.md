# Przewodnik dla Deweloperów - Workflow z Submodułem Android

## 🎯 Cel

Ten projekt używa **Git Submodule** do zarządzania kodem Android. Kod Android jest rozwijany w osobnym repozytorium, a w tym repo tylko zaciągamy zmiany i budujemy wersje.

## 📋 Zasady Pracy

### ✅ CO ROBIĆ w tym repo:

1. **Rozwijaj kod Vue/TypeScript** - normalna praca z kodem frontendowym
2. **Zaciągaj zmiany z repo Android** - używając submodułu
3. **Buduj aplikację** - używając Capacitor do synchronizacji
4. **Commituj zmiany Vue** - normalny workflow Git

### ❌ CZEGO NIE ROBIĆ w tym repo:

1. **NIE EDYTUJ** kodu w folderze `android/` bezpośrednio
2. **NIE COMMITUJ** zmian w `android/` do tego repo
3. **NIE MERGUJ** branchy w `android/` tutaj

Wszystkie zmiany dla Androida są robione w osobnym repo: https://github.com/fizzyappkm-bit/ionic-android.git

## 🔄 Workflow Synchronizacji

### Scenariusz 1: Pobieranie Nowych Zmian z Repo Android

Gdy w repo Android pojawią się nowe zmiany (np. zmigrowany ekran):

```bash
# Opcja 1: Użyj skryptu pomocniczego
npm run android:update

# Opcja 2: Ręcznie
cd android
git pull origin main
cd ..
git add android
git commit -m "Update android submodule: [opis zmian]"
git push
```

### Scenariusz 2: Sprawdzanie Statusu Submodułu

```bash
# Sprawdź czy submodule jest aktualny
npm run android:status
```

### Scenariusz 3: Budowanie Aplikacji

```bash
# Zbuduj aplikację web i zsynchronizuj z Android
npm run android:build

# Otwórz w Android Studio
npm run android:open
```

### Scenariusz 4: Praca nad Zmianami w Android (W Osobnym Repo)

Jeśli chcesz wprowadzić zmiany w kodzie Android:

1. **Przejdź do folderu android** (submodule):
   ```bash
   cd android
   ```

2. **Sprawdź czy jesteś na właściwym branchu**:
   ```bash
   git status
   git checkout main  # lub inny branch
   git pull origin main
   ```

3. **Wprowadź zmiany** w kodzie Kotlin

4. **Commit i push do repo Android**:
   ```bash
   git add .
   git commit -m "Migrate Tab2 to Kotlin"
   git push origin main
   ```

5. **Wróć do głównego repo i zaktualizuj submodule**:
   ```bash
   cd ..
   npm run android:update
   git add android
   git commit -m "Update android submodule: Tab2 migration"
   git push
   ```

## 🛠️ Narzędzia i Skrypty

### Skrypty npm

- `npm run android:update` - Aktualizuje submodule do najnowszej wersji
- `npm run android:status` - Sprawdza status submodułu
- `npm run android:build` - Buduje aplikację web i synchronizuje z Android
- `npm run android:open` - Otwiera projekt w Android Studio
- `npm run android:sync` - Synchronizuje z Capacitor

### Skrypty bash (w folderze `scripts/`)

- `./scripts/update-android.sh` - Aktualizacja submodułu
- `./scripts/check-android-status.sh` - Sprawdzanie statusu
- `./scripts/build-android.sh` - Budowanie aplikacji

## 📁 Struktura Projektu

```
ionic-app/
├── src/                    # Vue/TypeScript - główny kod
│   ├── views/             # Ekrany Vue
│   ├── components/        # Komponenty Vue
│   └── ...
├── android/                # Git Submodule → ionic-android repo
│   ├── app/
│   │   └── src/main/
│   │       └── kotlin/    # Kod Kotlin (NIE EDYTOWAĆ tutaj!)
│   └── ...
├── www/                    # Zbudowane pliki web
├── scripts/                # Skrypty pomocnicze
└── package.json           # Zależności i skrypty npm
```

## ⚠️ Częste Błędy i Rozwiązania

### Błąd: "Submodule not initialized"

```bash
git submodule update --init --recursive
```

### Błąd: "Submodule wskazuje na stary commit"

```bash
npm run android:update
# Następnie commit zmian w głównym repo
```

### Błąd: "Konflikt w submodule"

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

### Błąd: "Zmiany w android/ nie są commitowane"

To jest **normalne**! Submodule wskazuje na konkretny commit w repo Android. Jeśli chcesz zaktualizować do nowszego commita:

```bash
npm run android:update
git add android
git commit -m "Update android submodule"
```

## 🔍 Sprawdzanie Co Jest Zmigrowane

Sprawdź plik `MIGRATION_PLAN.md` aby zobaczyć które ekrany są już zmigrowane do Kotlin.

## 📚 Dodatkowa Dokumentacja

- [README.md](./README.md) - Główny README projektu
- [WORKFLOW.md](./WORKFLOW.md) - Szczegółowy workflow
- [SYNC_STRATEGY.md](./SYNC_STRATEGY.md) - Strategia synchronizacji
- [MIGRATION_PLAN.md](./MIGRATION_PLAN.md) - Plan migracji ekranów

## 💡 Wskazówki

1. **Zawsze sprawdzaj status** przed pracą: `npm run android:status`
2. **Aktualizuj submodule regularnie** aby mieć najnowsze zmiany
3. **Nie edytuj kodu Android w tym repo** - używaj osobnego repo
4. **Commituj aktualizacje submodułu** w głównym repo po zmianach w repo Android

