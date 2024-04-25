import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KWInputTextField extends StatefulWidget {
  const KWInputTextField({super.key, required this.label, this.initialVal = ''});

  final String label;
  final String initialVal;

  @override
  State<KWInputTextField> createState() => _KWInputTextFieldState();
}

class _KWInputTextFieldState extends State<KWInputTextField> {

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialVal);
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
        const SizedBox(height: 5,),
        TextField(
          controller: controller,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(50),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          ),
        ),
      ],
    );
  }
}