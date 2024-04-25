import 'package:flutter/material.dart';
import 'package:kwcalculator/app/repository/repository.dart';
import 'package:kwcalculator/app/view/calculator.dart';
import 'package:kwcalculator/app/view/config.dart';

import '../components/kwButton.dart';

class HelpPage extends StatefulWidget {
  HelpPage({super.key, required this.initialPage});
  bool initialPage = false;

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  bool showHelp = true;
  final Repository repository = Repository();

  void showHelpChanged(bool? value) {
    repository.saveShowHelpToStart(!showHelp);
    setState(() {
      showHelp = !showHelp;
    });
  }

  void continueBtnPressed() {
    if(widget.initialPage) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const CalculatorPage();
      }));
    } else  {
      Navigator.of(context).pop(MaterialPageRoute(builder: (context) {
        return const ConfigPage();
      }));
    }
  }

  void _loadShowHelp() async {
    bool value = await repository.getShowHelpToStart();
    if(widget.initialPage && !value) {
      continueBtnPressed();
    }
    setState(() {
      showHelp = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadShowHelp();
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
                    value: showHelp,
                    onChanged: showHelpChanged,
                    title: const Text('Mostrar ayuda al iniciar'),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 20,),
                  KWButton(text: widget.initialPage ? 'SALTAR' : 'VOLVER',onPressed: continueBtnPressed,)
                ],
              ),
            ),
          )
      ),
    );
  }
}