import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initBannerAd();
    inBannerAd();

    super.initState();
  }

  final adId = "ca-app-pub-3355640798916544/7193720462";
  final adId2 = "ca-app-pub-3355640798916544/5472410848";

  late BannerAd bannerAd;
  late BannerAd bannerAd2;
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adId2,
        listener: BannerAdListener(
          onAdLoaded: (ad) {},
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: const AdRequest());
    bannerAd.load();
  }

  inBannerAd() {
    bannerAd2 = BannerAd(
        size: AdSize.banner,
        adUnitId: adId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {},
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: const AdRequest());
    bannerAd2.load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: bannerAd.size.height.toDouble(),
                  width: bannerAd.size.width.toDouble(),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Center(child: AdWidget(ad: bannerAd)),
                ),
                Builder(
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .8,
                      child: InAppWebView(
                        initialUrlRequest: URLRequest(
                          url: Uri.parse('https://chat.openai.com/chat'),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                  ),
                  height: bannerAd2.size.height.toDouble(),
                  width: bannerAd2.size.width.toDouble(),
                  child: Center(child: AdWidget(ad: bannerAd2)),
                ),
              ],
            ),
          )),
    );
  }
}
