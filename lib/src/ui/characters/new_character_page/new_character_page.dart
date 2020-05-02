import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/characters/new_character_page/new_character_form/new_character_form.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

class NewCharacterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: OutlinedText.blackAndWhite('Create new character'),
      ),
      body: AppBackground(child: SafeArea(child: NewCharacterForm())),
    );
  }
}