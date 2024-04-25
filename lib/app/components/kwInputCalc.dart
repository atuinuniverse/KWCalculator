import 'package:flutter/material.dart';
import 'package:kwcalculator/app/components/kwInputField.dart';

class KWInputCalc extends StatelessWidget {
  KWInputCalc({super.key, required this.label});

  final String label;

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,),
        ),
        Row(
          children: [
            KWInputField(focusNode: _focusNode1, nextFocusNode: _focusNode2,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode2, nextFocusNode: _focusNode3,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode3, nextFocusNode: _focusNode4,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode4, nextFocusNode: _focusNode5,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode5, nextFocusNode: _focusNode6,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode6, isOrange: true,),
            const SizedBox(width: 10,),
            const Text('kWh',
              style: TextStyle(
                fontWeight: FontWeight.bold,),
            ),
          ],
        )
      ],
    );
  }
}