# Plan Migracji z Vue/TypeScript na Natywny Android Kotlin

## Strategia Stopniowej Migracji

### Faza 1: Przygotowanie ✅
- [x] Dodanie wsparcia dla Kotlin w projekcie
- [x] Konwersja MainActivity na Kotlin
- [x] Utworzenie struktury dla natywnych ekranów
- [x] Implementacja Tab1Fragment (licznik) w Kotlin

### Faza 2: Migracja Ekranów (W trakcie)

#### KROK 1: Tab1 - Licznik ✅
- **Status**: ZROBIONE
- **Vue**: `src/views/Tab1.vue`
- **Kotlin**: `android/app/src/main/kotlin/io/ionic/starter/native/Tab1Fragment.kt`
- **Layout**: `android/app/src/main/res/layout/fragment_tab1.xml`
- **Funkcjonalność**: Prosty licznik z przyciskiem

#### KROK 2: Tab2 - Explore Container
- **Status**: TODO
- **Vue**: `src/views/Tab2.vue`
- **Kotlin**: `Tab2Fragment.kt` (do utworzenia)
- **Funkcjonalność**: Wyświetlanie informacji z ExploreContainer

#### KROK 3: Tab3 - Explore Container
- **Status**: TODO
- **Vue**: `src/views/Tab3.vue`
- **Kotlin**: `Tab3Fragment.kt` (do utworzenia)
- **Funkcjonalność**: Podobny do Tab2

#### KROK 4: Tabs Navigation
- **Status**: TODO
- **Vue**: `src/views/Tabs.vue`
- **Kotlin**: Bottom Navigation w MainActivity lub osobny Fragment
- **Funkcjonalność**: Nawigacja między zakładkami

### Faza 3: Logika Biznesowa

#### Migracja TypeScript -> Kotlin
- [ ] Utworzyć odpowiedniki klas TypeScript w Kotlin
- [ ] Migracja logiki biznesowej
- [ ] Migracja stanu aplikacji (jeśli używasz state management)

### Faza 4: Finalizacja
- [ ] Usunięcie WebView
- [ ] Usunięcie zależności Vue/Capacitor (jeśli nie są potrzebne)
- [ ] Optymalizacja i testy

## Struktura Projektu

```
android/app/src/main/
├── kotlin/io/ionic/starter/
│   ├── MainActivity.kt              # Główna aktywność (hybrydowa)
│   └── native/
│       ├── Tab1Fragment.kt         # ✅ Zmigrowany
│       ├── Tab2Fragment.kt         # TODO
│       ├── Tab3Fragment.kt         # TODO
│       └── NativeNavigationHelper.kt  # Pomocnik nawigacji
└── res/
    └── layout/
        ├── fragment_tab1.xml       # ✅ Layout dla Tab1
        ├── fragment_tab2.xml       # TODO
        └── fragment_tab3.xml       # TODO
```

## Jak Migrować Kolejny Ekran?

1. **Utwórz Fragment w Kotlin**
   ```kotlin
   class Tab2Fragment : Fragment() {
       // Implementacja
   }
   ```

2. **Utwórz Layout XML**
   ```xml
   <!-- fragment_tab2.xml -->
   ```

3. **Dodaj do NativeNavigationHelper**
   ```kotlin
   private val migratedScreens = setOf(
       "/tabs/tab1",
       "/tabs/tab2"  // Dodaj tutaj
   )
   ```

4. **Zaimplementuj nawigację**
   - Zaktualizuj MainActivity aby obsługiwał routing
   - Dodaj logikę przełączania między WebView a natywnymi ekranami

5. **Przetestuj**
   - Upewnij się że ekran działa tak samo jak w Vue
   - Sprawdź wszystkie funkcjonalności

## Uwagi

- **Hybrydowy Approach**: Na początku aplikacja będzie działać zarówno z WebView (Vue) jak i natywnymi ekranami
- **Stopniowo**: Migruj jeden ekran na raz, testuj dokładnie
- **Zachowaj funkcjonalność**: Upewnij się że zmigrowany ekran działa identycznie jak w Vue

