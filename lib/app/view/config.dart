import 'package:flutter/material.dart';
import 'package:kwcalculator/app/components/kwInputMoneyField.dart';
import 'package:kwcalculator/app/components/kwNavbar.dart';
import 'package:kwcalculator/app/view/help.dart';

import '../components/kwButton.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool showHelp = false;

  void onPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HelpPage(initialPage: false);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const KWInputMoneyField(label: 'Valor kWh'),
                        const SizedBox(height: 20,),
                        KWButton(text: 'AYUDA', onPressed: onPressed),
                      ],
                    ),
                  ),
                  const KWNavbar(active: 1,)
                ]
            ),
          ),
        )
    );
  }
}