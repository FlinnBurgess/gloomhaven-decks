import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_background.dart';
import 'outlined_text.dart';

class SupportMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: OutlinedText.blackAndWhite('Support the developer'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: AppBackground(
            child: SafeArea(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              direction: Axis.vertical,
              spacing: 25,
              children: <Widget>[
                Container(
                    width: 300,
                    child: OutlinedText.blackAndWhite(
                        'Hi! Thanks for using Gloomhaven Deck Tracker. If you are enjoying the app, here are some ways you can support me',
                        TextAlign.center)),
                Container(
                    width: 300,
                    child: Center(
                        child: InkWell(
                      child: OutlinedText(
                          'Buy me a coffee', Colors.blue, Colors.black),
                      onTap: () =>
                          launch('https://www.buymeacoffee.com/flinnburgess'),
                    ))),
                Container(
                    width: 300,
                    child: Center(
                        child: InkWell(
                      child: OutlinedText(
                          'Rate the app', Colors.blue, Colors.black),
                      onTap: () => launch(
                          'https://play.google.com/store/apps/details?id=com.flinnburgess.gloomhaven_deck_tracker'),
                    ))),
                Container(
                    width: 300,
                    child: OutlinedText.blackAndWhite(
                        'If you spot any bugs or have suggestions for how I can improve the app, feel free to contact me at flinn@thetimelydeveloper.com',
                        TextAlign.center)),
              ],
            ),
          ],
        ))));
  }
}
