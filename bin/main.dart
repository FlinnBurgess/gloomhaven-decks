import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/home_page/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Character> characters;

  try {
    final file = await _localFile;
    String encodedCharacters = await file.readAsString();
    List<dynamic> decodedCharacters = jsonDecode(encodedCharacters);
    characters = Characters.fromJson(decodedCharacters);
  } catch (e) {
    characters = [];
  }

  runApp(ChangeNotifierProvider(
      create: (context) => Characters(characters),
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

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/characters.json');
}