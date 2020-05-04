import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/infusion_icons.dart';

enum Infusion { fire, ice, air, earth, light, dark }

Icon fireIcon = Icon(InfusionIcons.fire, color: Color.fromRGBO(194, 87, 55, 1));
Icon airIcon = Icon(InfusionIcons.air, color: Color.fromRGBO(152, 168, 171, 1));
Icon iceIcon = Icon(InfusionIcons.ice, color: Color.fromRGBO(92, 184, 216, 1));
Icon earthIcon = Icon(
    InfusionIcons.earth, color: Color.fromRGBO(136, 156, 76, 1));
Icon lightIcon = Icon(
  InfusionIcons.light, color: Color.fromRGBO(219, 168, 72, 1),);
Icon darkIcon = Icon(InfusionIcons.dark);

Icon getInfusionIcon(Infusion infusion) {
  switch (infusion) {
    case Infusion.fire:
      return fireIcon;
    case Infusion.ice:
      return iceIcon;
    case Infusion.air:
      return airIcon;
    case Infusion.earth:
      return earthIcon;
    case Infusion.light:
      return lightIcon;
    case Infusion.dark:
      return darkIcon;
  }
}