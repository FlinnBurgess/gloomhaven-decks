import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

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
      body: AppBackground(
          child: SafeArea(
              child: Column(
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
                    OutlinedText.blackAndWhite(
                        '2x cards act as +2 and Null cards act as -2')
                  ]),
                  Switch(
                      inactiveTrackColor: Colors.red,
                      inactiveThumbColor: Colors.grey,
                      activeTrackColor: Colors.green,
                      activeColor: Colors.grey,
                      value: snapshot.data,
                      onChanged: (value) {
                        setState(() {
                          setLessRandomnessSetting(value);
                        });
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
                      value: snapshot.data,
                      onChanged: (value) {
                        setState(() {
                          setHideUnlockableClassNamesSetting(value);
                        });
                      })
                ],
              )
                  : Container()),
        ],
              ))),
    );
  }
}
