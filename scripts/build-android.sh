#!/bin/bash

# Skrypt do budowania aplikacji Android
# Użycie: ./scripts/build-android.sh

set -e

echo "🔨 Budowanie aplikacji Android..."
echo ""

# Sprawdź czy submodule jest zainicjalizowany
if [ ! -d "android/.git" ]; then
    echo "❌ Submodule Android nie jest zainicjalizowany"
    echo "💡 Uruchom: git submodule update --init --recursive"
    exit 1
fi

# Zbuduj aplikację web
echo "📦 Budowanie aplikacji web..."
npm run build

# Zsynchronizuj z Capacitor
echo ""
echo "🔄 Synchronizacja z Capacitor..."
npx cap sync android

echo ""
echo "✅ Budowanie zakończone!"
echo ""
echo "💡 Aby otworzyć w Android Studio, uruchom:"
echo "   npx cap open android"
echo ""
echo "💡 Aby zbudować APK, uruchom w Android Studio lub:"
echo "   cd android && ./gradlew assembleDebug"

