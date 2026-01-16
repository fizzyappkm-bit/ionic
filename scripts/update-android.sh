#!/bin/bash

# Skrypt do aktualizacji submodułu Android do najnowszej wersji
# Użycie: ./scripts/update-android.sh

set -e

echo "🔄 Aktualizowanie submodułu Android..."

# Przejdź do folderu android
cd android

# Sprawdź czy jesteśmy w submodule
if [ ! -d ".git" ]; then
    echo "❌ Błąd: Folder android nie jest submodułem Git"
    exit 1
fi

# Pobierz najnowsze zmiany
echo "📥 Pobieranie najnowszych zmian z repo Android..."
git fetch origin

# Przełącz na main i zaktualizuj
echo "🔄 Przełączanie na branch main..."
git checkout main
git pull origin main

# Pokaż ostatnie commity
echo ""
echo "📋 Ostatnie 5 commitów w repo Android:"
git log --oneline -5

# Wróć do głównego katalogu
cd ..

# Sprawdź status submodułu
echo ""
echo "📊 Status submodułu w głównym repo:"
git status android

echo ""
echo "✅ Submodule zaktualizowany!"
echo ""
echo "💡 Aby zaktualizować referencję w głównym repo, uruchom:"
echo "   git add android"
echo "   git commit -m 'Update android submodule: [opis zmian]'"
echo "   git push"

