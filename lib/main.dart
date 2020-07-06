import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/decks_page.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

import 'src/settings/settings.dart';

TextTheme customTextTheme = TextTheme(
  bodyText2: TextStyle(fontSize: 20),
  button: TextStyle(fontSize: 20),
);

var sentry = SentryClient(
    dsn:
    "https://c4b85bb56d4f4514824ea548a80013a7@o387184.ingest.sentry.io/5222123");

//TODO IMPORTANT: app crashes after being closed for a while. No other side-effects at this point.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Characters characters = await Characters.load();
  bool userHasSeenConsentMessage = await userHasSeenPrivacyConsentMessage();

  runZoned(
          () =>
          runApp(ChangeNotifierProvider(
              create: (context) => characters,
              child: GloomhavenDeckTracker(userHasSeenConsentMessage))),
      onError: (Object error, StackTrace stacktrace) {
        try {
          sentry.captureException(exception: error, stackTrace: stacktrace);
          print('Error sent to sentry.io: $error');
        } catch (e) {
          print('Sending report to sentry.io failed: $e');
          print('Original error: $error');
        }
      });
}

class GloomhavenDeckTracker extends StatelessWidget {
  final bool userHasSeenConsentMessage;

  GloomhavenDeckTracker(this.userHasSeenConsentMessage);

  @override
  Widget build(BuildContext context) {
    precacheImage(
        AssetImage('images/backgrounds/atmospheric-dark-min.jpg'), context);
    return MaterialApp(
      title: 'Gloomhaven Deck Tracker',
      theme: ThemeData(
          fontFamily: 'PirataOne',
          textTheme: customTextTheme,
          unselectedWidgetColor: Colors.white),
      home: DecksPage(userHasSeenConsentMessage),
    );
  }
}
