import 'package:flutter/material.dart';
import 'package:kwcalculator/app/components/kwInputMoneyField.dart';
import 'package:kwcalculator/app/components/kwNavbar.dart';
import 'package:kwcalculator/app/repository/repository.dart';
import 'package:kwcalculator/app/view/help.dart';

import '../components/kwButton.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final Repository repository = Repository();
  bool showHelp = false;
  double kWhVal = 800.0;
  TextEditingController controller = TextEditingController(text: '800.0');

  void _loadKWhVal() async {
    double value = await repository.getValueKWh();
    setState(() {
      kWhVal = value;
      controller = TextEditingController(text: kWhVal.toString());
    });
  }

  void saveKWhVal(double value) {
    repository.saveValueKWh(value);
    setState(() {
      kWhVal = value;
    });
  }

  void onPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const HelpPage(initialPage: false);
    }));
  }

  @override
  void initState() {
    super.initState();
    _loadKWhVal();
    controller = TextEditingController(text: kWhVal.toString());
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
                        KWInputMoneyField(label: 'Valor kWh', initialVal: kWhVal, onValueChanged: saveKWhVal, controller: controller,),
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