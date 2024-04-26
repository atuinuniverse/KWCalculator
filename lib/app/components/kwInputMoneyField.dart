import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KWInputMoneyField extends StatefulWidget {
  const KWInputMoneyField({super.key, required this.label, this.initialVal = 0.0});

  final String label;
  final double initialVal;

  @override
  State<KWInputMoneyField> createState() => _KWInputMoneyFieldState();
}

class _KWInputMoneyFieldState extends State<KWInputMoneyField> {

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialVal.toString());
  }

  void onLostFocus() {
    if(controller.text == '') {
      controller.text = '800';
    }
  }

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onLostFocus();
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,),
        ),
        const SizedBox(height: 5,),
        TextField(
          focusNode: focusNode,
          controller: controller,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(50),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            prefix: const Text('\$'),
          ),
        ),
      ],
    );
  }
}