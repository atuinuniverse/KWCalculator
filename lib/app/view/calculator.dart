import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:kwcalculator/app/components/kwInputCalc.dart';
import 'package:kwcalculator/app/components/kwInputTextField.dart';
import 'package:kwcalculator/app/components/kwNavbar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kwcalculator/app/models/registry.dart';
import 'package:kwcalculator/app/repository/repository.dart';

import '../components/kwButton.dart';

class CalculatorPage extends StatefulWidget {
  CalculatorPage({super.key, this.adSize = AdSize.banner,});

  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-4066129298437405/5471315263'
      : 'ca-app-pub-4066129298437405/2795930901';

  final AdSize adSize;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final Repository repository = Repository();
  String name = '';
  double kWhStart = 0;
  double kWhEnd = 0;
  double kWhVal = 800.0;
  double total = 0;

  BannerAd? _bannerAd;

  void _loadKWhVal() async {
    double kWhVal = await repository.getValueKWh();
    setState(() {
      this.kWhVal = kWhVal;
    });
  }

  void calcPressed() {
    double diff = kWhEnd - kWhStart;
    setState(() {
      total = diff * kWhVal;
    });
    repository.addRegistry(Registry(name, DateTime.now(), diff, kWhVal, total));
  }

  void onNameChange(String value) {
    setState(() {
      name = value;
    });
  }

  void onkWhStartChange(double value) {
    setState(() {
      kWhStart = value;
    });
  }

  void onkWhEndChange(double value) {
    setState(() {
      kWhEnd = value;
    });
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

  String getStartName() {
    DateTime now = DateTime.now();
    String currentMonthName = DateFormat('MMMM', 'es_ES').format(now);
    return 'Lectura $currentMonthName';
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null);
    name = getStartName();
    _loadKWhVal();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
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
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            KWInputTextField(label: 'Nombre', initialVal: name, onValueChanged: onNameChange,),
                            const SizedBox(height: 20,),
                            KWInputCalc(label: 'Consumo inicial', onValueChanged: onkWhStartChange,),
                            const SizedBox(height: 20,),
                            KWInputCalc(label: 'Consumo final', onValueChanged: onkWhEndChange,),
                            const SizedBox(height: 20,),
                            if(total > 0)
                              Text('\$${total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,),
                              ),
                              const SizedBox(height: 20,),
                            KWButton(text: 'CALCULAR',onPressed: calcPressed,),
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