import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class NightShroud {
  String name;
  AttackModifierDeck attackModifierDeck;
  List<List> inactivePerks;
  List<List> activePerks;

  NightShroud(this.name) {
    attackModifierDeck = AttackModifierDeck();
    inactivePerks = [
      [Perk.removeTwoMinusOnes(), Perk.TWO_PERKS_AVAILABLE],
      [Perk.removeFourZeros(), Perk.ONE_PERK_AVAILABLE],
      [
        Perk.additive([DamageChangeCard.withInfusion(-1, Infusion.dark, false)],
            'Add one -1 and [dark infusion] card'),
        Perk.TWO_PERKS_AVAILABLE
      ],
      [
        Perk.replacement([
          DamageChangeCard.withInfusion(-1, Infusion.dark, false)
        ], [
          DamageChangeCard.withInfusion(1, Infusion.dark, false)
        ], 'Replace one -1 and [dark infusion] card with one +1 and [dark infusion] card'),
        Perk.TWO_PERKS_AVAILABLE
      ],
      [
        Perk.additive(
            [DamageChangeCard.withCondition(1, Condition.invisible, false)],
            'Add one +1 [INVISIBLE] card'),
        Perk.ONE_PERK_AVAILABLE
      ],
      [
        Perk.additive([
          ConditionCard(Condition.muddle, true),
          ConditionCard(Condition.muddle, true),
          ConditionCard(Condition.muddle, true)
        ], 'Add three [ROLLING] [MUDDLE] cards'),
        Perk.TWO_PERKS_AVAILABLE
      ],
      [
        Perk.additive([
          AttackEffectCard(AttackEffect.heal, 1, true),
          AttackEffectCard(AttackEffect.heal, 1, true),
        ], 'Add two [ROLLING] [HEAL+1] cards'),
        Perk.ONE_PERK_AVAILABLE
      ],
      [
        Perk.additive([
          ConditionCard(Condition.curse, true),
          ConditionCard(Condition.curse, true),
        ], 'Add two [ROLLING] [CURSE] cards'),
        Perk.ONE_PERK_AVAILABLE
      ],
      [
        Perk.additive([AttackEffectCard(AttackEffect.addTarget, 1, true)],
            'Add one [ROLLING] [ADD TARGET] card'),
        Perk.ONE_PERK_AVAILABLE
      ],
      [
        Perk.additive([
          DamageChangeCard.minusOne(),
          DamageChangeCard.minusOne(),
        ], 'Ignore negative scenario effects and add two +1 cards'),
        Perk.ONE_PERK_AVAILABLE
      ]
    ];

    activePerks = [...inactivePerks];
    activePerks.map((perk) => perk[1] = 0);
  }
}
