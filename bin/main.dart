import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/home_page/home_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Characters characters = await Characters.load();

  runApp(ChangeNotifierProvider(
      create: (context) => characters,
      child: GloomhavenDeckTracker()));
}

class GloomhavenDeckTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gloomhaven Deck Tracker',
      home: HomePage(),
    );
  }
}