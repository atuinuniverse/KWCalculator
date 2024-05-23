import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KWInputMoneyField extends StatefulWidget {
  const KWInputMoneyField({
    super.key,
    required this.label,
    this.initialVal = 0.0,
    required this.onValueChanged,
    required this.controller
  });

  final String label;
  final double initialVal;
  final Function(double) onValueChanged;
  final TextEditingController controller;

  @override
  State<KWInputMoneyField> createState() => _KWInputMoneyFieldState();
}

class _KWInputMoneyFieldState extends State<KWInputMoneyField> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus) {
      if (widget.controller.text == '0' || widget.controller.text == '0.0') {
        widget.controller.clear();
      }
    } else {
      if (widget.controller.text.isEmpty) {
        widget.controller.text = widget.initialVal.toString();
      }
    }
  }

  void onChanged(String? value) {
    double priceKWh = double.tryParse(value!) ?? 0.0;
    widget.onValueChanged(priceKWh);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5,),
        TextField(
          focusNode: focusNode,
          controller: widget.controller,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(50),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            prefix: const Text('\$'),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
