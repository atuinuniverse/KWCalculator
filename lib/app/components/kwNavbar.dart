import 'package:flutter/material.dart';
import 'package:kwcalculator/app/utils/kwtheme.dart';
import 'package:kwcalculator/app/view/calculator.dart';
import 'package:kwcalculator/app/view/config.dart';
import 'package:kwcalculator/app/view/history.dart';

class KWNavbar extends StatefulWidget {
  const KWNavbar({super.key, required this.active});

  final int active;

  @override
  State<KWNavbar> createState() => _KWNavbarState();
}

class _KWNavbarState extends State<KWNavbar> {

  void goToBtnPressed(int value) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      if(value == 1) {
        return const ConfigPage();
      } else if(value == 2)  {
        return const CalculatorPage();
      } else {
        return const HistoryPage();
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
                  goToBtnPressed(1);
                },
                child: Container(
                  color: widget.active == 1 ? Colors.grey : KWTheme().backgroundColor,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.settings),
                        const SizedBox(width: 2),
                        Text(
                          'CONFIGURACIÓN',
                          style: TextStyle(
                            fontSize: 10,
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
                  goToBtnPressed(2);
                },
                child: Container(
                  color: widget.active == 2 ? Colors.grey : KWTheme().backgroundColor,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.monetization_on_outlined),
                        const SizedBox(width: 2),
                        Text(
                          'CALCULAR',
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
                  goToBtnPressed(3);
                },
                child: Container(
                  color: widget.active == 3 ? Colors.grey : KWTheme().backgroundColor,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.receipt_long_outlined),
                        const SizedBox(width: 2),
                        Text(
                          'HISTORICO',
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
          ],
        ),
      ),
    );
  }
}