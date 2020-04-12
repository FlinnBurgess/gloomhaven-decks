import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';

void main(List<String> arguments) {
  var deck = AttackModifierDeck();
  deck.shuffle();
  var modifierCard = deck.draw();
  var result = AttackModifierResult();
  modifierCard.applyEffect(result);
}
