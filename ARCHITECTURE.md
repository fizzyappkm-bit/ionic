# Architektura Projektu - Submoduły i Migracja

## Przegląd Architektury

Projekt używa **Git Submodules** do zarządzania kodem w różnych repozytoriach, umożliwiając stopniową migrację z Vue/TypeScript na natywny Android Kotlin.

## Struktura Repozytoriów

```
┌─────────────────────────────────────────────────────────────┐
│  ionic-app (główne repo)                                     │
│  https://github.com/your-org/ionic-app.git                  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  src/                                                 │   │
│  │  ├── views/ (Tab1.vue, Tab2.vue, Tab3.vue)          │   │
│  │  └── components/                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  android/ (Git Submodule)                            │   │
│  │  → ionic-android repo                                │   │
│  │                                                       │   │
│  │  ┌───────────────────────────────────────────────┐    │   │
│  │  │  app/src/main/kotlin/                        │    │   │
│  │  │  ├── MainActivity.kt                         │    │   │
│  │  │  └── native/                                 │    │   │
│  │  │      ├── Tab1Fragment.kt ✅                  │    │   │
│  │  │      ├── Tab2Fragment.kt ⏳                   │    │   │
│  │  │      └── NativeNavigationHelper.kt            │    │   │
│  │  └───────────────────────────────────────────────┘    │   │
│  │                                                       │   │
│  │  ┌───────────────────────────────────────────────┐    │   │
│  │  │  ionic-source/ (Git Submodule)               │    │   │
│  │  │  → ionic repo (pliki Vue jako referencja)    │    │   │
│  │  │                                               │    │   │
│  │  │  ┌───────────────────────────────────────┐    │    │   │
│  │  │  │  src/views/                          │    │    │   │
│  │  │  │  ├── Tab1.vue (referencja)          │    │    │   │
│  │  │  │  ├── Tab2.vue (do migracji)         │    │    │   │
│  │  │  │  └── Tab3.vue (do migracji)         │    │    │   │
│  │  │  └───────────────────────────────────────┘    │    │   │
│  │  └───────────────────────────────────────────────┘    │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

## Przepływ Danych

### 1. Development w Głównym Repo (ionic-app)

```
Developer → Edytuje src/views/Tab2.vue
         → Commit do ionic-app repo
         → Push do GitHub
```

### 2. Migracja w Repo Android (ionic-android)

```
Developer → cd android/
         → cd ionic-source/
         → git pull (pobiera najnowsze zmiany z ionic-app)
         → Analizuje Tab2.vue
         → Tworzy Tab2Fragment.kt
         → Commit do ionic-android repo
         → Push do GitHub
```

### 3. Aktualizacja w Głównym Repo

```
Developer → cd android/
         → git pull (pobiera najnowsze zmiany z ionic-android)
         → cd ..
         → git add android
         → git commit -m "Update android submodule"
         → Push do GitHub
```

## Zalety Tego Podejścia

✅ **Separacja odpowiedzialności**
- Kod Vue w głównym repo
- Kod Kotlin w osobnym repo
- Każde repo ma własną historię i workflow

✅ **Dostęp do plików źródłowych**
- Repo android ma dostęp do plików Vue przez `ionic-source/`
- Można analizować i migrować ekran po ekranie

✅ **Niezależne wersjonowanie**
- Android i Vue mogą mieć różne cykle release
- Można wrócić do poprzedniej wersji submodule

✅ **Czytelna historia**
- Każde repo ma własną historię zmian
- Łatwo śledzić co zostało zmigrowane

✅ **Stopniowa migracja**
- Można migrować ekran po ekranie
- Hybrydowe podejście - część Vue, część Kotlin

## Workflow Migracji Ekranu

### Przykład: Migracja Tab2

1. **W głównym repo (ionic-app)**:
   ```bash
   # Rozwijasz Tab2.vue
   git add src/views/Tab2.vue
   git commit -m "Update Tab2.vue"
   git push
   ```

2. **W repo android (ionic-android)**:
   ```bash
   cd android
   cd ionic-source
   git pull origin main  # Pobierz najnowsze zmiany
   cd ../..
   
   # Analizuj Tab2.vue
   cat ionic-source/src/views/Tab2.vue
   
   # Migruj do Kotlin
   # - Utwórz Tab2Fragment.kt
   # - Utwórz fragment_tab2.xml
   # - Zaimplementuj logikę
   
   git add .
   git commit -m "Migrate Tab2 to Kotlin"
   git push origin main
   ```

3. **W głównym repo (ionic-app)**:
   ```bash
   cd android
   git pull origin main
   cd ..
   git add android
   git commit -m "Update android submodule: Tab2 migration"
   git push
   ```

## Mapowanie Ekranów

| Ekran | Vue (ionic-app) | Kotlin (ionic-android) | Status |
|-------|----------------|------------------------|--------|
| Tab1 | `src/views/Tab1.vue` | `android/app/.../Tab1Fragment.kt` | ✅ Zmigrowany |
| Tab2 | `src/views/Tab2.vue` | `android/app/.../Tab2Fragment.kt` | ⏳ Do migracji |
| Tab3 | `src/views/Tab3.vue` | `android/app/.../Tab3Fragment.kt` | ⏳ Do migracji |

## Komendy Git Submodule

### Inicjalizacja (pierwszy raz)
```bash
git submodule update --init --recursive
```

### Aktualizacja submodułu android
```bash
cd android
git pull origin main
cd ..
git add android
git commit -m "Update android submodule"
```

### Aktualizacja ionic-source (w repo android)
```bash
cd android/ionic-source
git pull origin main
cd ../..
git add android/ionic-source
git commit -m "Update ionic-source submodule"
```

## Uwagi

- **Nie edytuj** kodu w `android/` bezpośrednio w głównym repo
- **Używaj** `ionic-source/` w repo android jako referencji do migracji
- **Commituj** aktualizacje submodułów w głównym repo po zmianach
- **Dokumentuj** które ekrany są zmigrowane w `MIGRATION_PLAN.md`

