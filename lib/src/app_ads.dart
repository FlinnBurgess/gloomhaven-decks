import 'package:ads/ads.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';

Ads ads;
final String _adsAppId = 'ca-app-pub-5990110104526103~5616181503';
//TODO remember to replace test IDs with your actual IDs
final String perkBannerAdId = 'ca-app-pub-3940256099942544/6300978111';
final String deckPageBannerAdId = 'ca-app-pub-3940256099942544/6300978111';
final String shuffleInterstitialAdId = 'ca-app-pub-3940256099942544/1033173712';

Future<void> initAds() async {
  bool personalizedAds = await getPersonalizedAdsSetting();
  ads ??= Ads(_adsAppId, keywords: [
    'Board Games',
    'Gloomhaven',
    'Frosthaven',
    'Games',
    'Fantasy',
    'Story'
  ], nonPersonalizedAds: !personalizedAds);
}
