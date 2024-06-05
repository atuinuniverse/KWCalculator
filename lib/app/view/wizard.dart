import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kwcalculator/app/components/kwButton.dart';
import 'package:kwcalculator/app/components/kwInputMoneyField.dart';
import 'package:kwcalculator/app/components/kwInputTextField.dart';
import 'package:kwcalculator/app/components/kwNavbar.dart';
import 'package:kwcalculator/app/models/registry.dart';

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
  TextEditingController _invoiceValue = TextEditingController(text: '0.0');
  TextEditingController _kwhValue = TextEditingController(text: '0.0');
  TextEditingController _metersCount = TextEditingController(text: '2');
  TextEditingController _additionalValue = TextEditingController(text: '0');
  TextEditingController _mainMeter = TextEditingController(text: '0');

  double total = 0;
  double costKWh = 0;
  int cantMeters = 2;
  double additionalCost = 0;
  String concept = '';
  double mainCant = 0;

  BannerAd? _bannerAd;
  List<Registry> records = <Registry>[];
  List<double> metrics = <double>[];
  int step = 0;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _invoiceValue.dispose();
    _kwhValue.dispose();
    _metersCount.dispose();
    _additionalValue.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    bannerAd.load();
  }

  void _calc() {
    for (int i = 0; i < cantMeters - 1; i++) {
      Registry registry = Registry(
        'Medidor ' + (i + 1).toString(),
        DateTime.now(),
        metrics[i],
        costKWh,
        metrics[i] * costKWh + additionalCost,
        metrics[i] * costKWh,
        concept,
      );
      records.add(registry);
    }
    Registry registry = Registry(
      'Medidor principal',
      DateTime.now(),
      mainCant,
      costKWh,
      mainCant * costKWh + additionalCost,
      mainCant * costKWh,
      concept,
    );
    records.add(registry);
  }

  Widget showPage() {
    switch (step) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: widget.adSize.height.toDouble() + 10,),
            const Image(image: AssetImage('images/2.png'), width: 50,),
            const SizedBox(height: 20,),
            KWInputMoneyField(
              label: 'Por favor, ingresa el valor total de tu factura eléctrica:',
              onValueChanged: (double value) {
                setState(() {
                  total = value;
                });
              },
              controller: _invoiceValue,
            ),
            const SizedBox(height: 20,),
            KWButton(text: 'CONTINUAR', onPressed: () => setState(() {
              step++;
            })),
            KWButton(text: 'ATRAS', onPressed: () => setState(() {
              step--;
            })),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: widget.adSize.height.toDouble() + 10,),
            const Image(image: AssetImage('images/3.png'), width: 50,),
            const SizedBox(height: 20,),
            KWInputMoneyField(
              label: 'En tu factura eléctrica, busca el costo por kWh:',
              onValueChanged: (double value) {
                setState(() {
                  costKWh = value;
                });
              },
              controller: _kwhValue,
            ),
            const SizedBox(height: 20,),
            KWButton(text: 'CONTINUAR', onPressed: () => setState(() {
              step++;
            })),
            KWButton(text: 'ATRAS', onPressed: () => setState(() {
              step--;
            })),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: widget.adSize.height.toDouble() + 10,),
            const Image(image: AssetImage('images/4.png'), width: 50,),
            const SizedBox(height: 20,),
            KWInputTextField(
              label: '¿En cuántos contadores quieres dividir tu recibo eléctrico?',
              initialVal: '2',
              onValueChanged: (String value) {
                setState(() {
                  cantMeters = int.tryParse(value) ?? 2;
                  // Aseguramos que la lista metrics tenga la longitud correcta
                  if (metrics.length != cantMeters - 1) {
                    metrics = List<double>.filled(cantMeters - 1, 0.0);
                  }
                });
              },
            ),
            const SizedBox(height: 20,),
            KWButton(text: 'CONTINUAR', onPressed: () => setState(() {
              step++;
            })),
            KWButton(text: 'ATRAS', onPressed: () => setState(() {
              step--;
            })),
          ],
        );
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: widget.adSize.height.toDouble() + 10,),
            const Image(image: AssetImage('images/5.png'), width: 50,),
            const SizedBox(height: 20,),
            KWInputMoneyField(
              label: '¿Hay algún costo que desees especificar para distribuirlo equitativamente entre los contadores?',
              onValueChanged: (double value) {
                setState(() {
                  additionalCost = value;
                });
              },
              controller: _additionalValue,
            ),
            const SizedBox(height: 20,),
            KWInputTextField(
              label: 'Concepto',
              initialVal: '',
              onValueChanged: (String value) {
                setState(() {
                  concept = value.isEmpty ? 'Adicional' : value;
                });
              },
            ),
            const SizedBox(height: 20,),
            KWButton(text: 'CONTINUAR', onPressed: () => setState(() {
              mainCant = (total - additionalCost) / costKWh;
              _mainMeter = TextEditingController(text: mainCant.toString());
              step++;
            })),
            KWButton(text: 'ATRAS', onPressed: () => setState(() {
              step--;
            })),
          ],
        );
      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: widget.adSize.height.toDouble() + 10,),
            const Image(image: AssetImage('images/4.png'), width: 50,),
            const SizedBox(height: 20,),
            Text('Indica el consumo por cada contador'),
            ...List.generate((cantMeters - 1), (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                  onChanged: (String value) {
                    double val = double.tryParse(value) ?? 0;
                    if (index >= 0 && index < metrics.length) {
                      setState(() {
                        metrics[index] = val;
                      });
                    }
                    mainCant = (total - additionalCost) / costKWh;
                    metrics.forEach((metric) {
                      mainCant -= metric;
                    });
                    _mainMeter.text = mainCant.toString();
                  },
                ),
              );
            }),
            TextField(
              enabled: false,
              controller: _mainMeter,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              ),
            ),
            const SizedBox(height: 20,),
            KWButton(text: 'CONTINUAR', onPressed: () => setState(() {
              _calc();
              step++;
            })),
            KWButton(text: 'ATRAS', onPressed: () => setState(() {
              step--;
            })),
          ],
        );
      case 6:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: records.map((record) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(record.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,),
                    ),
                    Text(record.formattedDate()),
                    Row(
                      children: [
                        Text('\$${record.total}',
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                    Text('${record.kWh}kWh * \$${record.kWhValue}'),
                    Text('\$${record.total} + \$${record.total} de Adicional'),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('images/1.png'), width: 50,),
            const SizedBox(height: 20,),
            const Text(
              '¡Bienvenido! Estoy aquí para ayudarte a calcular el costo de tu factura eléctrica. Por favor, sigue las instrucciones para comenzar.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20,),
            KWButton(text: 'ENTENDIDO', onPressed: () => setState(() {
              step++;
            })),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: widget.adSize.width.toDouble(),
              height: widget.adSize.height.toDouble(),
              child: _bannerAd == null
                  ? const SizedBox()
                  : AdWidget(ad: _bannerAd!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Container(
                    child: showPage(),
                  ),
                ),
              ),
            ),
            const KWNavbar(active: 2,)
          ],
        ),
      ),
    );
  }
}
