import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/conditions/condition_icons.dart';

enum Condition {
  bless,
  curse,
  disarm,
  immobilize,
  invisible,
  muddle,
  poison,
  strengthen,
  stun,
  wound,
  regenerate
}

Icon blessIcon =
    Icon(ConditionIcons.bless, color: Color.fromRGBO(197, 159, 71, 1));
Icon inactiveBlessIcon = Icon(ConditionIcons.bless, color: Colors.black45);
Icon curseIcon =
    Icon(ConditionIcons.curse, color: Color.fromRGBO(125, 75, 191, 1));
Icon inactiveCurseIcon = Icon(ConditionIcons.curse, color: Colors.black45);
Icon disarmIcon = Icon(ConditionIcons.disarm, color: Colors.grey);
Icon immobilizeIcon =
    Icon(ConditionIcons.immobilize, color: Color.fromRGBO(139, 46, 44, 1));
Icon woundIcon =
    Icon(ConditionIcons.wound, color: Color.fromRGBO(199, 98, 57, 1));
Icon muddleIcon = Icon(ConditionIcons.muddle, color: Colors.brown);
Icon stunIcon = Icon(ConditionIcons.stun, color: Colors.blue[800]);
Icon poisonIcon =
    Icon(ConditionIcons.poison, color: Color.fromRGBO(117, 120, 99, 1));
Icon invisibleIcon = Icon(ConditionIcons.invisible);
Icon strengthenIcon =
    Icon(ConditionIcons.strengthen, color: Color.fromRGBO(90, 139, 185, 1));
Icon regenerateIcon =
    Icon(ConditionIcons.regenerate, color: Color.fromRGBO(211, 0, 161, 1));

Icon getConditionIcon(Condition condition) {
  switch (condition) {
    case Condition.bless:
      return blessIcon;
    case Condition.curse:
      return curseIcon;
    case Condition.disarm:
      return disarmIcon;
    case Condition.immobilize:
      return immobilizeIcon;
    case Condition.invisible:
      return invisibleIcon;
    case Condition.muddle:
      return muddleIcon;
    case Condition.poison:
      return poisonIcon;
    case Condition.strengthen:
      return strengthenIcon;
    case Condition.stun:
      return stunIcon;
    case Condition.wound:
      return woundIcon;
    case Condition.regenerate:
      return regenerateIcon;
  }
}
