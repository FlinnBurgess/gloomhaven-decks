import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class NightShroud {
  String name;
  AttackModifierDeck attackModifierDeck;
  List inactivePerks;
  List activePerks;

  NightShroud(this.name) {
    inactivePerks = [
      [
        Perk.subtractive(
            [DamageChangeCard.minusOne(), DamageChangeCard.minusOne()]),
        Perk.TWO_PERKS_AVAILABLE
      ],
      [
        Perk.subtractive([
          DamageChangeCard.zero(),
          DamageChangeCard.zero(),
          DamageChangeCard.zero(),
          DamageChangeCard.zero()
        ]),
        Perk.ONE_PERK_AVAILABLE
      ],
      [
        Perk.additive(
            [DamageChangeCard.withInfusion(-1, Infusion.dark, false)]),
        Perk.TWO_PERKS_AVAILABLE
      ],
    ];
  }
}
