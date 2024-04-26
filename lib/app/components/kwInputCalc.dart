import 'package:flutter/material.dart';
import 'package:kwcalculator/app/components/kwInputField.dart';

class KWInputCalc extends StatefulWidget {
  const KWInputCalc({super.key, required this.label, required this.onValueChanged});
  final String label;
  final Function(double) onValueChanged;

  @override
  State<KWInputCalc> createState() => _KWInputCalcState();
}

class _KWInputCalcState extends State<KWInputCalc> {

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  String num1 = '0';
  String num2 = '0';
  String num3 = '0';
  String num4 = '0';
  String num5 = '0';
  String num6 = '0';

  TextEditingController controller1 = TextEditingController(text: '0');
  TextEditingController controller2 = TextEditingController(text: '0');
  TextEditingController controller3 = TextEditingController(text: '0');
  TextEditingController controller4 = TextEditingController(text: '0');
  TextEditingController controller5 = TextEditingController(text: '0');
  TextEditingController controller6 = TextEditingController(text: '0');

  void getNumber()
  {
    String composeNumber = '$num1$num2$num3$num4$num5.$num6';
    double number = double.tryParse(composeNumber) ?? 0.0;
    widget.onValueChanged(number);
  }

  void onNum1Change(String value) {
    setState(() {
      num1 = value;
      controller1 = TextEditingController(text: num1);
      getNumber();
    });
  }

  void onNum2Change(String value) {
    setState(() {
      num2 = value;
      controller2 = TextEditingController(text: num2);
      getNumber();
    });
  }

  void onNum3Change(String value) {
    setState(() {
      num3 = value;
      controller3 = TextEditingController(text: num3);
      getNumber();
    });
  }

  void onNum4Change(String value) {
    setState(() {
      num4 = value;
      controller4 = TextEditingController(text: num4);
      getNumber();
    });
  }

  void onNum5Change(String value) {
    setState(() {
      num5 = value;
      controller5 = TextEditingController(text: num5);
      getNumber();
    });
  }

  void onNum6Change(String value) {
    setState(() {
      num6 = value;
      controller6 = TextEditingController(text: num6);
      getNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,),
        ),
        Row(
          children: [
            KWInputField(focusNode: _focusNode1, nextFocusNode: _focusNode2, onValueChanged: onNum1Change, controller: controller1,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode2, nextFocusNode: _focusNode3, onValueChanged: onNum2Change, controller: controller2,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode3, nextFocusNode: _focusNode4, onValueChanged: onNum3Change, controller: controller3,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode4, nextFocusNode: _focusNode5, onValueChanged: onNum4Change, controller: controller4,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode5, nextFocusNode: _focusNode6, onValueChanged: onNum5Change, controller: controller5,),
            const SizedBox(width: 10,),
            KWInputField(focusNode: _focusNode6, isOrange: true, onValueChanged: onNum6Change, controller: controller6,),
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