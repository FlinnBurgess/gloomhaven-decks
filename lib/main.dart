import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/home_page/home_page.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

TextTheme customTextTheme = TextTheme(
  body1: TextStyle(fontSize: 20),
  button: TextStyle(fontSize: 20),
);

var sentry = SentryClient(
    dsn:
    "https://c4b85bb56d4f4514824ea548a80013a7@o387184.ingest.sentry.io/5222123");

//TODO IMPORTANT: app crashes after being closed for a while, and deletes all characters in the process. Could have something to do with the change in the way characters are serialized.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Characters characters = await Characters.load();

  runZoned(
          () =>
          runApp(ChangeNotifierProvider(
              create: (context) => characters, child: GloomhavenDeckTracker())),
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
      home: HomePage(),
    );
  }
}
