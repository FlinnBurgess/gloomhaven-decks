import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect_icons.dart';

enum AttackEffect { addTarget, heal, pierce, pull, push, shield, refreshItem }

Icon addTargetIcon =
Icon(AttackEffectIcons.add_target, color: Color.fromRGBO(139, 46, 44, 1));
Icon healIcon = Icon(
    AttackEffectIcons.heal, color: Color.fromRGBO(139, 46, 44, 1),);
Icon pierceIcon =
Icon(AttackEffectIcons.pierce, color: Color.fromRGBO(181, 135, 87, 1));
Icon pullIcon = Icon(AttackEffectIcons.pull, color: Colors.grey);
Icon pushIcon = Icon(AttackEffectIcons.push, color: Colors.grey);
Icon shieldIcon = Icon(AttackEffectIcons.shield, color: Colors.grey,);
