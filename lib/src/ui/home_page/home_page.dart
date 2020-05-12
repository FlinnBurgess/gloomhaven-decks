import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/characters/character_list_page/character_list_page.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/decks_page.dart';
import 'package:gloomhaven_decks/src/ui/settings/settings_page/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';

class HomePage extends StatelessWidget {
  final bool userHasSeenConsentMessage;

  HomePage(this.userHasSeenConsentMessage);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (!userHasSeenConsentMessage) {
        showPrivacyConsentMessage(context);
      }
    });

    Wakelock.disable();
    return Scaffold(
      appBar: null,
      body: Center(
        child: AppBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CharacterListPage()));
                  },
                  child: Text('Characters')),
              RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DecksPage()));
                  },
                  child: Text('Decks')),
              RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                  child: Text('Settings')),
            ],
          ),
        ),
      ),
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
                  'By using this app, you are agreeing to the terms laid out in the privacy policy. Please indicate below whether you consent to being served personalised ads.'),
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
                  color: Colors.green[200],
                  textColor: Colors.black,
                  onPressed: () {
                    setPersonalizedAdsSetting(true);
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                        'I would like to be provided personalized ads.',
                        textAlign: TextAlign.center,
                      ))),
              RaisedButton(
                color: Colors.red[200],
                textColor: Colors.black,
                onPressed: () {
                  setPersonalizedAdsSetting(false);
                  Navigator.pop(context);
                },
                child: Center(child: Text('I do not want personalized ads.')),
              )
            ],
          );
        });
  }
}
