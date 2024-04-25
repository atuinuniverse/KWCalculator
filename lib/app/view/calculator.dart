import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kwcalculator/app/components/kwInputCalc.dart';
import 'package:kwcalculator/app/components/kwInputTextField.dart';
import 'package:kwcalculator/app/components/kwNavbar.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../components/kwButton.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String name = '';

  void calcPressed() {
    int starVal = 0;
    print('calcular');
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            KWInputTextField(label: 'Nombre', initialVal: name,),
                            const SizedBox(height: 20,),
                            KWInputCalc(label: 'Consumo inicial'),
                            const SizedBox(height: 20,),
                            KWInputCalc(label: 'Consumo final'),
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