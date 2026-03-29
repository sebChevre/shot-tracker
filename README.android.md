# Shot Tracker - Guide Android

Ce document explique l'installation de l'environnement Android, la configuration Flutter, puis le build et le déploiement de l'application.

## 1) Prérequis (macOS)

1. Homebrew
   - https://brew.sh

2. Flutter (Dart inclus)

   brew install --cask flutter

3. Java 17 (recommandé pour Gradle/Android modernes)

   brew install --cask temurin@17

4. Android Studio (SDK Android, platform-tools, émulateur)

   brew install --cask android-studio

5. Vérifier que la ligne de commande Android est installée
   - Ouvrir Android Studio au moins une fois
   - Installer Android SDK, Android SDK Platform-Tools, Android SDK Command-line Tools

## 2) Configuration shell (zsh)

Ajouter dans ~/.zshrc:

export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"

Puis recharger:

source ~/.zshrc

## 3) Validation de l'environnement

1. Vérifier Flutter

   flutter doctor -v

2. Accepter les licences Android

   flutter doctor --android-licenses

3. Vérifier les appareils/émulateurs disponibles

   flutter devices
   flutter emulators

## 4) Préparer le projet

Depuis la racine du projet:

cd /Users/seb/Dart/shot-tracker
flutter pub get

Si nécessaire:

flutter clean
flutter pub get

## 5) Lancer en Android (debug)

Option A, sur émulateur:

1. Démarrer un émulateur

   flutter emulators --launch <emulator_id>

2. Lancer l'application

   flutter run -d <device_id>

Option B, sur téléphone Android:

1. Activer les options développeur et le débogage USB
2. Connecter le téléphone
3. Vérifier qu'il apparaît

   flutter devices

4. Lancer

   flutter run -d <device_id>

## 6) Build Android pour distribution

### APK (installation directe)

flutter build apk --release

Fichier généré:
- [build/app/outputs/flutter-apk/app-release.apk](build/app/outputs/flutter-apk/app-release.apk)

### App Bundle AAB (Google Play)

flutter build appbundle --release

Fichier généré:
- [build/app/outputs/bundle/release/app-release.aab](build/app/outputs/bundle/release/app-release.aab)

## 7) Signature release (important)

Pour publier, il faut signer l'app avec une clé privée.

1. Générer un keystore

   keytool -genkey -v -keystore ~/shot-tracker-upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

2. Créer [android/key.properties](android/key.properties) avec:

storePassword=<mot_de_passe_store>
keyPassword=<mot_de_passe_key>
keyAlias=upload
storeFile=/Users/<user>/shot-tracker-upload-keystore.jks

3. Configurer la signature dans [android/app/build.gradle](android/app/build.gradle)
   - Ajouter le chargement de key.properties
   - Définir signingConfigs.release
   - Associer buildTypes.release a signingConfigs.release

Note: ce projet est actuellement configuré avec la clé debug pour release. Pour publication réelle, il faut passer sur une vraie signature release.

## 8) Déployer sur un appareil Android

Après build APK release:

adb install -r build/app/outputs/flutter-apk/app-release.apk

Si adb n'est pas trouvé:
- Vérifier Android SDK Platform-Tools
- Ajouter platform-tools au PATH

## 9) Dépannage rapide

1. Erreur Gradle ou Java
   - Vérifier Java 17:

     java -version

2. Android SDK introuvable
   - Ouvrir Android Studio et installer SDK + tools
   - Refaire:

     flutter doctor -v

3. Build qui échoue après changement de dépendances

   flutter clean
   flutter pub get
   flutter build apk --release

4. Device non détecté
   - Vérifier câble/autorisation USB
   - Tester:

     adb devices

## 10) Commandes utiles

- Lister les dépendances obsolètes

  flutter pub outdated

- Analyse statique

  flutter analyze

- Tests

  flutter test
