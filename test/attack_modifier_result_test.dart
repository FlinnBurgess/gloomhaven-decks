import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:test/test.dart';

void main() {
  group('Result comparison', () {
    AttackModifierResult firstResult;
    AttackModifierResult secondResult;

    setUp(() {
      firstResult = AttackModifierResult();
      secondResult = AttackModifierResult();
    });

    group('Worse results', () {
      test(
          'between two attack modifier cards with no additional effects, the one with lower damage is worse',
          () {
        DamageChangeCard twoDamage = DamageChangeCard.base(2);
        firstResult.applyCardEffect(twoDamage, false);

        DamageChangeCard oneDamage = DamageChangeCard.base(1);
        secondResult.applyCardEffect(oneDamage, false);

        expect(worseResult(firstResult, secondResult), secondResult);
      });

      test(
          'between two attack modifier cards with the same additional effects, the one with lower damage is worse',
          () {
        DamageChangeCard oneDamageWithWound =
            DamageChangeCard.withCondition(1, Condition.wound, "brute");
        firstResult.applyCardEffect(oneDamageWithWound, false);
        DamageChangeCard twoDamageWithWound =
            DamageChangeCard.withCondition(2, Condition.wound, "brute");
        secondResult.applyCardEffect(twoDamageWithWound, false);

        expect(worseResult(firstResult, secondResult), firstResult);
      });

      test(
          'a comparison of attack modifier cards with differing damage changes and differing additional effects is ambiguous',
          () {
        DamageChangeCard oneDamageWithWound =
            DamageChangeCard.withCondition(1, Condition.wound, "brute");
        firstResult.applyCardEffect(oneDamageWithWound, false);

        DamageChangeCard fiftyDamageWithPushOne =
            DamageChangeCard.withAttackEffect(
                50, AttackEffect.push, 1, "brute");
        secondResult.applyCardEffect(fiftyDamageWithPushOne, false);

        expect(worseResult(firstResult, secondResult), null);
      });

      test(
          'a comparison of attack modifier cards with the same damage changes and differing additional effects is ambiguous',
          () {
        DamageChangeCard oneDamageWithImmobilize =
            DamageChangeCard.withCondition(1, Condition.immobilize, "brute");
        firstResult.applyCardEffect(oneDamageWithImmobilize, false);

        DamageChangeCard oneDamageWithShieldOne =
            DamageChangeCard.withAttackEffect(
                1, AttackEffect.shield, 1, "brute");
        secondResult.applyCardEffect(oneDamageWithShieldOne, false);

        expect(worseResult(firstResult, secondResult), null);
      });
    });

    group('Better results', () {
      test(
          'between two attack modifier cards with no additional effects, the one with higher damage is better',
          () {
        DamageChangeCard twoDamage = DamageChangeCard.base(2);
        firstResult.applyCardEffect(twoDamage, false);

        DamageChangeCard oneDamage = DamageChangeCard.base(1);
        secondResult.applyCardEffect(oneDamage, false);

        expect(betterResult(firstResult, secondResult), firstResult);
      });

      test(
          'between two attack modifier cards with the same additional effects, the one with higher damage is better',
          () {
        DamageChangeCard oneDamageWithWound =
            DamageChangeCard.withCondition(1, Condition.wound, "brute");
        firstResult.applyCardEffect(oneDamageWithWound, false);
        DamageChangeCard twoDamageWithWound =
            DamageChangeCard.withCondition(2, Condition.wound, "brute");
        secondResult.applyCardEffect(twoDamageWithWound, false);

        expect(betterResult(firstResult, secondResult), secondResult);
      });

      test(
          'a comparison of attack modifier cards with differing damage changes and differing additional effects is ambiguous',
          () {
        DamageChangeCard oneDamageWithWound =
            DamageChangeCard.withCondition(1, Condition.wound, "brute");
        firstResult.applyCardEffect(oneDamageWithWound, false);

        DamageChangeCard fiftyDamageWithPushOne =
            DamageChangeCard.withAttackEffect(
                50, AttackEffect.push, 1, "brute");
        secondResult.applyCardEffect(fiftyDamageWithPushOne, false);

        expect(betterResult(firstResult, secondResult), null);
      });

      test(
          'a comparison of attack modifier cards with the same damage changes and differing additional effects is ambiguous',
          () {
        DamageChangeCard oneDamageWithImmobilize =
            DamageChangeCard.withCondition(1, Condition.immobilize, "brute");
        firstResult.applyCardEffect(oneDamageWithImmobilize, false);

        DamageChangeCard oneDamageWithShieldOne =
            DamageChangeCard.withAttackEffect(
                1, AttackEffect.shield, 1, "brute");
        secondResult.applyCardEffect(oneDamageWithShieldOne, false);

        expect(betterResult(firstResult, secondResult), null);
      });
    });
  });
}
