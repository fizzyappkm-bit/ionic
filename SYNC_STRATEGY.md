# Strategia Synchronizacji między Repozytoriami

## Architektura

```
ionic (główne repo - Vue/TypeScript)
├── src/              # Vue komponenty
├── android/          # Git Submodule → ionic-android repo
└── package.json      # Zależności Vue
```

## Workflow Migracji

### 1. Zmiany w Vue (ionic repo)
- Rozwijasz funkcjonalności w Vue
- Commitujesz do `ionic` repo
- Gdy ekran jest gotowy do migracji → migrujesz do Kotlin

### 2. Migracja do Kotlin (ionic-android repo)
- Otwierasz `android/` folder (submodule)
- Migrujesz ekran z Vue na Kotlin
- Commitujesz do `ionic-android` repo
- Aktualizujesz submodule w głównym repo

### 3. Synchronizacja
- Submodule wskazuje na konkretny commit w `ionic-android`
- Możesz zaktualizować wersję submodule gdy potrzebujesz nowych zmian

## Komendy Git

### Inicjalizacja Submodule
```bash
# W głównym repo (ionic)
git submodule add https://github.com/fizzyappkm-bit/ionic-android.git android
git commit -m "Add android as submodule"
```

### Praca z Submodule

**Aktualizacja do najnowszej wersji:**
```bash
cd android
git pull origin main
cd ..
git add android
git commit -m "Update android submodule to latest"
```

**Praca nad zmianami w Android:**
```bash
cd android
# Wprowadzasz zmiany
git add .
git commit -m "Migrate Tab2 to Kotlin"
git push origin main
cd ..
git add android
git commit -m "Update android submodule with Tab2 migration"
```

**Klonowanie repo z submodule:**
```bash
git clone --recursive https://github.com/fizzyappkm-bit/ionic.git
# lub jeśli już sklonowane:
git submodule update --init --recursive
```

## Strategia Migracji Ekran po Ekranie

1. **Tab1** ✅ - Już zmigrowany
2. **Tab2** - Migracja w toku
   - Vue: `src/views/Tab2.vue`
   - Kotlin: `android/app/src/main/kotlin/.../Tab2Fragment.kt`
3. **Tab3** - Do migracji
4. **Tabs Navigation** - Na końcu

## Zalety tego Podejścia

✅ **Niezależne wersjonowanie** - Android i Vue mogą mieć różne cykle release
✅ **Czytelna historia** - Każde repo ma własną historię zmian
✅ **Łatwa współpraca** - Android dev może pracować niezależnie
✅ **Stopniowa migracja** - Możesz migrować ekran po ekranie
✅ **Rollback** - Możesz wrócić do poprzedniej wersji submodule

## Uwagi

- Zawsze aktualizuj submodule po zmianach w repo Android
- Używaj znaczników (tags) w repo Android dla stabilnych wersji
- Dokumentuj które ekrany są zmigrowane w `MIGRATION_PLAN.md`

