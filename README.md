# passwordgenerator

Breve generatore di password realizzato con Flutter.

## Descrizione
Questo progetto è una semplice app Flutter che genera password sicure e casuali. Può servire come punto di partenza per aggiungere opzioni di configurazione (lunghezza, inclusione di simboli, numeri, lettere maiuscole/minuscole) e integrazione con salvataggio sicuro.

## Funzionalità principali
- Generazione di password random
- Opzioni configurabili (lunghezza, caratteri)
- Interfaccia minimale basata su `lib/main.dart`

## Come eseguire
1. Assicurati di avere Flutter installato: https://flutter.dev
2. Dalla cartella del progetto esegui:

```bash
flutter pub get
flutter run
```

Per creare build:

```bash
flutter build apk    # Android
flutter build ios    # iOS (su macOS)
flutter build web    # Web
```

## Struttura del progetto
- `lib/main.dart`: punto di ingresso dell'app
- `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/`: progetti specifici per piattaforme
