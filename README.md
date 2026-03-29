# Shot Tracker

Application Flutter de suivi de tirs, utilisable en Web et Android.

Guide Android complet: [README.android.md](README.android.md)

## 1) Installation de Flutter et Dart (macOS)

Flutter inclut déjà Dart, il ne faut donc pas installer Dart séparément.

1. Installer Homebrew (si nécessaire)
	- https://brew.sh

2. Installer Flutter

	brew install --cask flutter

3. Vérifier l'installation

	flutter --version
	flutter doctor -v

## 2) Configuration du projet

Depuis la racine du projet [README.md](README.md):

1. Se placer dans le dossier

	cd /Users/seb/Dart/shot-tracker

2. Activer le support Web (une seule fois sur la machine)

	flutter config --enable-web

3. Télécharger les dépendances

	flutter pub get

## 3) Compiler en Web (production)

Commande:

flutter build web

Résultat:
- Les fichiers statiques sont générés dans [build/web](build/web).

## 4) Lancer en Web (développement)

Option A, dans Chrome:

flutter run -d chrome

Option B, via serveur web local Flutter:

flutter run -d web-server

Si tu utilises l'option B, une URL locale est affichée dans le terminal (exemple: http://localhost:54039), à ouvrir dans le navigateur.

## 5) Servir la version de production localement

1. Compiler si ce n'est pas déjà fait

	flutter build web

2. Servir le dossier généré

	cd build/web
	python3 -m http.server 8080

3. Ouvrir

	http://localhost:8080

## 6) Dépannage rapide

1. Erreur de dépendances
	- Relancer:

	  flutter clean
	  flutter pub get

2. Chrome non détecté
	- Vérifier les devices Web:

	  flutter devices

3. Erreur au run mais build ok
	- Tenter:

	  flutter run -d web-server

## 7) Commandes utiles

- Analyse statique

  flutter analyze

- Exécuter les tests

  flutter test

- Lister les dépendances obsolètes

  flutter pub outdated
