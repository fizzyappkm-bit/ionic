#!/bin/bash

# Skrypt do sprawdzania statusu submodułu Android
# Użycie: ./scripts/check-android-status.sh

set -e

echo "📊 Status submodułu Android"
echo "============================"
echo ""

# Sprawdź czy submodule istnieje
if [ ! -d "android" ]; then
    echo "❌ Folder android nie istnieje"
    echo "💡 Uruchom: git submodule update --init --recursive"
    exit 1
fi

# Sprawdź czy jest submodule
if [ ! -d "android/.git" ]; then
    echo "❌ Folder android nie jest submodułem Git"
    exit 1
fi

# Sprawdź remote
echo "🔗 Remote URL:"
cd android
git remote -v | head -1
echo ""

# Sprawdź aktualny branch i commit
echo "📍 Aktualny branch:"
git branch --show-current
echo ""

echo "📍 Aktualny commit:"
git log --oneline -1
echo ""

# Sprawdź czy są nowe zmiany
echo "🔄 Sprawdzanie nowych zmian..."
git fetch origin --quiet

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u} 2>/dev/null || echo "")

if [ -z "$REMOTE" ]; then
    echo "⚠️  Brak ustawionego upstream branch"
else
    if [ "$LOCAL" = "$REMOTE" ]; then
        echo "✅ Submodule jest aktualny (na najnowszym commicie)"
    else
        echo "⚠️  Submodule nie jest aktualny!"
        echo "   Lokalny:  $LOCAL"
        echo "   Remote:   $REMOTE"
        echo ""
        echo "💡 Aby zaktualizować, uruchom: ./scripts/update-android.sh"
    fi
fi

# Wróć do głównego katalogu
cd ..

# Sprawdź status w głównym repo
echo ""
echo "📊 Status w głównym repo:"
if git diff --quiet android; then
    echo "✅ Submodule jest zsynchronizowany z głównym repo"
else
    echo "⚠️  Submodule ma niezcommitowane zmiany w głównym repo"
    git status android
fi

echo ""
echo "📋 Ostatnie 5 commitów w repo Android:"
cd android
git log --oneline -5
cd ..

