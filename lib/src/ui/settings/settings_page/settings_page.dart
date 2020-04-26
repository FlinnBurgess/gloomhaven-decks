import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FutureBuilder<bool>(
              future: getLessRandomnessSetting(),
              initialData: false,
              builder: (context, snapshot) =>
              snapshot.hasData
                  ? Column(
                children: <Widget>[
                  Wrap(children: [
                    Text('2x cards act as +2 and Null cards act as -2')
                  ]),
                  Switch(
                      value: snapshot.data,
                      onChanged: (value) {
                        setLessRandomnessSetting(value);
                      })
                ],
              )
                  : Container()),
          FutureBuilder<bool>(
              future: getHideUnlockableClassNamesSetting(),
              initialData: true,
              builder: (context, snapshot) =>
              snapshot.hasData
                  ? Column(
                children: <Widget>[
                  Wrap(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        'Hide non-starting character class names on new character page',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]),
                  Switch(
                      value: snapshot.data,
                      onChanged: (value) {
                        setHideUnlockableClassNamesSetting(value);
                      })
                ],
              )
                  : Container())
        ],
      ),
    );
  }
}
