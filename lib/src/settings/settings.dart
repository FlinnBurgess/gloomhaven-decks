import 'package:shared_preferences/shared_preferences.dart';

const LESS_RANDOMNESS = 'lessRandomness';
const HIDE_UNLOCKABLE_CLASS_NAMES = 'hideClassNames';
const PERSONALIZED_ADS_CONSENT = 'privacyConsent';

Future<bool> getLessRandomnessSetting() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  return settings.containsKey(LESS_RANDOMNESS)
      ? settings.getBool(LESS_RANDOMNESS)
      : false;
}

setLessRandomnessSetting(bool setting) async {
  final SharedPreferences settings = await SharedPreferences.getInstance();
  await settings.setBool(LESS_RANDOMNESS, setting);
}

Future<bool> getHideUnlockableClassNamesSetting() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  return settings.containsKey(HIDE_UNLOCKABLE_CLASS_NAMES)
      ? settings.getBool(HIDE_UNLOCKABLE_CLASS_NAMES)
      : true;
}

setHideUnlockableClassNamesSetting(bool setting) async {
  final SharedPreferences settings = await SharedPreferences.getInstance();
  await settings.setBool(HIDE_UNLOCKABLE_CLASS_NAMES, setting);
}

Future<bool> userHasSeenPrivacyConsentMessage() async {
  final SharedPreferences settings = await SharedPreferences.getInstance();
  return settings.containsKey(PERSONALIZED_ADS_CONSENT);
}

Future<bool> getPersonalizedAdsSetting() async {
  final SharedPreferences settings = await SharedPreferences.getInstance();
  return settings.containsKey(PERSONALIZED_ADS_CONSENT)
      ? settings.getBool(PERSONALIZED_ADS_CONSENT)
      : false;
}

setPersonalizedAdsSetting(bool setting) async {
  final SharedPreferences settings = await SharedPreferences.getInstance();
  await settings.setBool(PERSONALIZED_ADS_CONSENT, setting);
}
