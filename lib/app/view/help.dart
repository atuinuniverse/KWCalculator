import 'package:flutter/material.dart';
import 'package:kwcalculator/app/view/calculator.dart';

import '../components/kwButton.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  bool showHelp = false;

  void shoeHelpChanged(bool? value) {
    showHelp = !showHelp;
    print(showHelp);
  }

  void continueBtnPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const CalculatorPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(image: AssetImage('images/logo.png')),
                  const SizedBox(height: 50,),
                  const Text('KWCalculator', style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(height: 20,),
                  const Text(
                    'Bienvenido a nuestra aplicación móvil de cálculo de consumo de energía, una herramienta inteligente y fácil de usar diseñada para ayudarte a controlar y gestionar tus gastos de energía de manera eficiente.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  CheckboxListTile(
                    value: false,
                    onChanged: shoeHelpChanged,
                    title: const Text('Mostrar ayuda al iniciar'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 20,),
                  KWButton(text: 'SALTAR',onPressed: continueBtnPressed,)
                ],
              ),
            ),
          )
      ),
    );
  }
}