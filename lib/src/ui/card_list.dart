import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';

showCardList(context, List<AttackModifierCard> cards) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.maxFinite,
                child: ListView(
                  children: cards
                      .map((card) => Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: card.getImage()))
                      .toList(),
                ),
              )),
        );
      });
}
