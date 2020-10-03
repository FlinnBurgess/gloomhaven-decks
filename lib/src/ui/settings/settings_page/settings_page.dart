import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: OutlinedText.blackAndWhite('Settings'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: AppBackground(child:
          SafeArea(child: Consumer<Settings>(builder: (context, settings, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Wrap(children: [
                  OutlinedText.blackAndWhite(
                      '2x cards act as +2 and Null cards act as -2')
                ]),
                Switch(
                    inactiveTrackColor: Colors.red,
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: Colors.green,
                    activeColor: Colors.grey,
                    value: settings.lessRandomnessSetting,
                    onChanged: (value) {
                      setState(() {
                        settings.lessRandomnessSetting = value;
                      });
                    })
              ],
            ),
            Column(
              children: <Widget>[
                Wrap(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: OutlinedText.blackAndWhite(
                      'Hide non-starting character class names on new character page',
                      TextAlign.center,
                    ),
                  )
                ]),
                Switch(
                    inactiveTrackColor: Colors.red,
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: Colors.green,
                    activeColor: Colors.grey,
                    value: settings.hideUnlockableClassNamesSetting,
                    onChanged: (value) {
                      setState(() {
                        settings.hideUnlockableClassNamesSetting = value;
                      });
                    })
              ],
            ),
            Column(
              children: <Widget>[
                Wrap(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: OutlinedText.blackAndWhite(
                      'Auto-calculate attack modifier results',
                      TextAlign.center,
                    ),
                  )
                ]),
                Switch(
                    inactiveTrackColor: Colors.red,
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: Colors.green,
                    activeColor: Colors.grey,
                    value: settings.autoCalculateResultsSetting,
                    onChanged: (value) {
                      setState(() {
                        settings.autoCalculateResultsSetting = value;
                      });
                    })
              ],
            ),
          ],
        );
      }))),
    );
  }
}
