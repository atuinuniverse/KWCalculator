import 'package:flutter/material.dart';
import 'package:kwcalculator/app/utils/kwtheme.dart';
import 'package:kwcalculator/app/view/calculator.dart';
import 'package:kwcalculator/app/view/config.dart';
import 'package:kwcalculator/app/view/history.dart';
import 'package:kwcalculator/app/view/wizard.dart';

class KWNavbar extends StatefulWidget {
  const KWNavbar({super.key, required this.active});

  final int active;

  @override
  State<KWNavbar> createState() => _KWNavbarState();
}

class _KWNavbarState extends State<KWNavbar> {

  void goToBtnPressed(int value) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      switch (value) {
        case 1:
          return const ConfigPage();
        case 3:
          return CalculatorPage();
        case 4:
          return const HistoryPage();
        default:
          return WizardPage();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: KWTheme().textColor,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if(widget.active != 1) {
                    goToBtnPressed(1);
                  }
                },
                child: Container(
                  color: widget.active == 1 ? Colors.grey : KWTheme().backgroundColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.settings),
                        const SizedBox(height: 5),
                        Text(
                          'CONFIGURACIÓN',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: widget.active == 1 ? FontWeight.bold : FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if(widget.active != 2) {
                    goToBtnPressed(2);
                  }
                },
                child: Container(
                  color: widget.active == 2 ? Colors.grey : KWTheme().backgroundColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.monetization_on_outlined),
                        const SizedBox(height: 5),
                        Text(
                          'ASISTENTE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: widget.active == 2 ? FontWeight.bold : FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if(widget.active != 3) {
                    goToBtnPressed(3);
                  }
                },
                child: Container(
                  color: widget.active == 3 ? Colors.grey : KWTheme().backgroundColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calculate_outlined),
                        const SizedBox(height: 5),
                        Text(
                          'CALCULADORA',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: widget.active == 3 ? FontWeight.bold : FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if(widget.active != 4) {
                    goToBtnPressed(4);
                  }
                },
                child: Container(
                  color: widget.active == 4 ? Colors.grey : KWTheme().backgroundColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.receipt_long_outlined),
                        const SizedBox(height: 5),
                        Text(
                          'HISTORICO',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: widget.active == 4 ? FontWeight.bold : FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}