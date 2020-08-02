import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  bool _lessRandomnessSetting;
  bool _hideUnlockableClassNamesSetting;
  var _personalizedAdConsentSetting;
  bool _userHasSeenConsentMessage;

  static const LESS_RANDOMNESS = 'lessRandomness';
  static const HIDE_UNLOCKABLE_CLASS_NAMES = 'hideClassNames';
  static const PERSONALIZED_ADS_CONSENT = 'privacyConsent';

  Settings(this._lessRandomnessSetting, this._hideUnlockableClassNamesSetting,
      this._personalizedAdConsentSetting, this._userHasSeenConsentMessage);

  static Future<Settings> load() async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    bool lessRandomnessSetting = settings.containsKey(LESS_RANDOMNESS)
        ? settings.getBool(LESS_RANDOMNESS)
        : false;
    bool hideUnlockableClassNamesSetting =
        settings.containsKey(HIDE_UNLOCKABLE_CLASS_NAMES)
            ? settings.getBool(HIDE_UNLOCKABLE_CLASS_NAMES)
            : true;
    bool userHasSeenConsentMessage =
        settings.containsKey(PERSONALIZED_ADS_CONSENT);
    bool adConsentSetting = settings.containsKey(PERSONALIZED_ADS_CONSENT)
        ? settings.getBool(PERSONALIZED_ADS_CONSENT)
        : false;

    return Settings(lessRandomnessSetting, hideUnlockableClassNamesSetting,
        adConsentSetting, userHasSeenConsentMessage);
  }

  Future<void> save() async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    await settings.setBool(LESS_RANDOMNESS, _lessRandomnessSetting);
    await settings.setBool(
        HIDE_UNLOCKABLE_CLASS_NAMES, _hideUnlockableClassNamesSetting);
    await settings.setBool(
        PERSONALIZED_ADS_CONSENT, _personalizedAdConsentSetting);
  }

  bool get userHasSeenConsentMessage => _userHasSeenConsentMessage;

  set userHasSeenConsentMessage(bool value) {
    _userHasSeenConsentMessage = value;
    save();
  }

  get personalizedAdConsentSetting => _personalizedAdConsentSetting;

  set personalizedAdConsentSetting(value) {
    _personalizedAdConsentSetting = value;
    save();
    notifyListeners();
  }

  bool get hideUnlockableClassNamesSetting => _hideUnlockableClassNamesSetting;

  set hideUnlockableClassNamesSetting(bool value) {
    _hideUnlockableClassNamesSetting = value;
    save();
    notifyListeners();
  }

  bool get lessRandomnessSetting => _lessRandomnessSetting;

  set lessRandomnessSetting(bool value) {
    _lessRandomnessSetting = value;
    save();
    notifyListeners();
  }
}
