import 'package:flutter/material.dart';
import 'package:kwcalculator/app/components/kwInputCalc.dart';

import '../components/kwButton.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {

  void calcPressed() {
    int starVal = 0;
    print('calcular');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    KWInputCalc(label: 'Consumo inicial'),
                    const SizedBox(height: 20,),
                    KWInputCalc(label: 'Consumo final'),
                    const SizedBox(height: 20,),
                    KWButton(text: 'CALCULAR',onPressed: calcPressed,)
                  ],
                ),
              )
          ),
        )
    );
  }
}