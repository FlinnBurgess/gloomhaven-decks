import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Spellweaver extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Spellweaver(this.name) {
    perks = [
      Perk.removeFourZeros(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceCard(DamageChangeCard(-1, 'cards/base/minus-1-damage.png'),
          DamageChangeCard(1, 'cards/spellweaver/plus-1-damage.png'),
          Perk.TWO_PERKS_AVAILABLE, 'Replace one -1 card with one +1 card'),
      Perk.addTwoPlusOnes(
          Perk.TWO_PERKS_AVAILABLE, 'cards/spellweaver/plus-1-damage.png'),
      Perk.addCard(DamageChangeCard.withCondition(
          0, Condition.stun, 'cards/spellweaver/stun.png'),
          Perk.ONE_PERK_AVAILABLE, 'Add one +0 [STUN] card'),
      Perk.addCard(DamageChangeCard.withCondition(
          1, Condition.wound, 'cards/spellweaver/plus-1-damage-and-wound.png'),
          Perk.ONE_PERK_AVAILABLE, 'Add one +1 [WOUND] card'),
      Perk.addCard(
          DamageChangeCard.withCondition(1, Condition.immobilize,
              'cards/spellweaver/plus-1-damage-and-immobilize.png'),
          Perk.ONE_PERK_AVAILABLE,
          'Add one +1 [IMMOBILIZE] card'),
      Perk.addCard(DamageChangeCard.withCondition(
          1, Condition.curse, 'cards/spellweaver/plus-1-damage-and-curse.png'),
          Perk.ONE_PERK_AVAILABLE, 'Add one +1 [CURSE] card'),
      Perk.addCard(DamageChangeCard.withInfusion(
          2, Infusion.fire, 'cards/spellweaver/plus-2-damage-and-fire.png'),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +2 [FIRE INFUSION] card'),
      Perk.addCard(DamageChangeCard.withInfusion(
          2, Infusion.ice, 'cards/spellweaver/plus-2-damage-and-ice.png'),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +2 [ICE INFUSION] card'),
      Perk.addCards([
        InfusionCard(Infusion.earth, 'cards/spellweaver/rolling-earth.png'),
        InfusionCard(Infusion.air, 'cards/spellweaver/rolling-air.png')
      ], Perk.ONE_PERK_AVAILABLE,
          'Add one [EARTH INFUSION] and one [AIR INFUSION] card'),
      Perk.addCards([
        InfusionCard(Infusion.light, 'cards/spellweaver/rolling-light.png'),
        InfusionCard(Infusion.dark, 'cards/spellweaver/rolling-dark.png')
      ], Perk.ONE_PERK_AVAILABLE,
          'Add one [LIGHT INFUSION] and one [DARK INFUSION] card'),
    ];
  }
}
