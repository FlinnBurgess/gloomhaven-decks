import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/characters/character_list_page/character_list_page.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/attack_modifier_deck_tab/attack_modifier_deck_tab.dart';
import 'package:gloomhaven_decks/src/ui/navigation_drawer.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';

class DecksPage extends StatefulWidget {
  final bool userHasSeenConsentMessage;

  DecksPage(this.userHasSeenConsentMessage);

  @override
  State<StatefulWidget> createState() => DecksPageState();
}

class DecksPageState extends State<DecksPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (!this.widget.userHasSeenConsentMessage) {
        showPrivacyConsentMessage(context);
      }
    });

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

        List<AttackModifierDeckTab> characterDeckPages = activeCharacters
            .map((character) => AttackModifierDeckTab(
                  character: character,
                  saveCharacters: () => characters.save(),
                ))
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
            drawer: NavigationDrawer(),
            body: AppBackground(
                child: SafeArea(
                    child: activeCharacters.isEmpty
                        ? Column(
                            children: <Widget>[
                              OutlinedText.blackAndWhite(
                                  "You don't have any active characters!"),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: RaisedButton(
                                  child: Text("Add some now"),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CharacterListPage()));
                                  },
                                ),
                              )
                            ],
                          )
                        : TabBarView(
                            children: characterDeckPages,
                          ))),
          ),
        );
      },
    );
  }

  void showPrivacyConsentMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Privacy and data usage'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                  'By using this app, you are agreeing to the terms laid out in the privacy policy.'),
              InkWell(
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.blue[800]),
                ),
                onTap: () =>
                    launch(
                        'https://sites.google.com/view/gloomhaven-deck-tracker/privacy-policy'),
              )
            ]),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    setPersonalizedAdsSetting(true);
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                        'Okay.',
                        textAlign: TextAlign.center,
                      ))),
            ],
          );
        });
  }

}
