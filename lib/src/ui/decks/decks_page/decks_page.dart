import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/app_ads.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/attack_modifier_deck_tab/attack_modifier_deck_tab.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

class DecksPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DecksPageState();
}

class DecksPageState extends State<DecksPage> {

  @override
  void initState() {
    super.initState();
    initAds().whenComplete(() =>
        ads.showBannerAd(
            adUnitId: deckPageBannerAdId, size: AdSize.smartBanner));
  }

  @override
  void dispose() {
    ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Consumer<Characters>(
      builder: (context, characters, child) {
        List<Character> activeCharacters = characters.characters
            .where((character) => character.isActive)
            .toList();

        List<Tab> characterTabs = activeCharacters
            .map<Tab>((character) => Tab(
          icon: Icon(character.characterIcon),
          text: character.name,
        ))
            .toList();

        List<AttackModifierDeckTab> characterDeckPages =
        activeCharacters.map((character) =>
            AttackModifierDeckTab(
              character: character, saveCharacters: () => characters.save(),))
            .toList();

        return DefaultTabController(
          length: activeCharacters.length,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: OutlinedText.blackAndWhite('Decks'),
              bottom: TabBar(
                tabs: characterTabs,
                indicatorWeight: 3,
                indicatorColor: Colors.white,
              ),
            ),
            body: AppBackground(child: SafeArea(child: TabBarView(
              children: characterDeckPages,
            ))),
          ),
        );
      },
    );
  }
}
