import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kwcalculator/app/components/kwNavbar.dart';

class WizardPage extends StatefulWidget {
  WizardPage({super.key, this.adSize = AdSize.banner});

  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-4066129298437405/5471315263'
      : 'ca-app-pub-4066129298437405/2795930901';

  final AdSize adSize;

  @override
  State<WizardPage> createState() => _WizardPageState();
}

class _WizardPageState extends State<WizardPage> {

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: widget.adSize.width.toDouble(),
              height: widget.adSize.height.toDouble(),
              child: _bannerAd == null
                  ? const SizedBox()
                  : AdWidget(ad: _bannerAd!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: [
                  Center(
                    child: Text('1'),
                  )
                ],
              ),
            ),
            const KWNavbar(active: 2,)
          ]
        ),
      ),
    );
  }
}