import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) => Scaffold(
        appBar: AppBar(title: Text('Settings')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Wrap(children: [
                  Text('2x cards act as +2 and Null cards act as -2')
                ]),
                Switch(
                    value: settings.lessRandomness,
                    onChanged: (value) {
                      settings.setLessRandomnessSetting(value);
                      settings.save();
                    })
              ],
            ),
            Column(
              children: <Widget>[
                Wrap(children: [
                  Text(
                      'Hide non-starting character class names on new character page')
                ]),
                Switch(
                    value: settings.hideNonStarterClassNames,
                    onChanged: (value) {
                      settings.setHideNonStarterClassNames(value);
                      settings.save();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
