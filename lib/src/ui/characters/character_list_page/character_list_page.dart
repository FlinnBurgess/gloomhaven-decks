import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/navigation_drawer.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../../app_rating.dart';
import 'character_list/character_list.dart';

class CharacterListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          message:
              'If you like this app, please take a little bit of your time to review it!\n\nIt really helps me and it shouldn\'t take you more than one minute.\n\nIf there are improvements you would like to see, you can contact me at flinn@thetimelydeveloper.com',
          // The dialog message.
          rateButton: 'RATE',
          noButton: 'NO THANKS',
          laterButton: 'MAYBE LATER',
          ignoreIOS: false,
          onDismissed: () =>
              rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
        );
      }
    });

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: OutlinedText.blackAndWhite('Characters'),
        ),
        drawer: NavigationDrawer(),
        body: AppBackground(
          child: SafeArea(child: CharacterList()),
        ));
  }
}
