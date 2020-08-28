import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/app_rating.dart';
import 'package:gloomhaven_decks/src/characters/player_characters.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';
import 'package:gloomhaven_decks/src/ui/decks_and_items/decks_and_items_page/decks_and_items_page.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

import 'src/shop/shop.dart';

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
  PlayerCharacters characters = await PlayerCharacters.load();
  Shop shop = await Shop.load();
  Settings settings = await Settings.load();

  runZoned(
      () => runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => characters,
              ),
              ChangeNotifierProvider(
                create: (_) => shop,
              ),
              ChangeNotifierProvider(
                create: (_) => settings,
              ),
            ],
            child: GloomhavenDeckTracker(settings.userHasSeenConsentMessage),
          )), onError: (Object error, StackTrace stacktrace) {
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
    Future.delayed(Duration.zero, () {
      rateMyApp.init();
    });

    return MaterialApp(
      title: 'Gloomhaven Deck Tracker',
      theme: ThemeData(
          fontFamily: 'PirataOne',
          textTheme: customTextTheme,
          unselectedWidgetColor: Colors.white),
      home: DecksAndItemsPage(userHasSeenConsentMessage),
    );
  }
}
