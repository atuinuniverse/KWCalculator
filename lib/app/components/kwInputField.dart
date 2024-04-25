import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/kwtheme.dart';

class KWInputField extends StatelessWidget {
  KWInputField({super.key, this.isOrange = false, required this.focusNode, this.nextFocusNode});

  final bool isOrange;
  FocusNode focusNode;
  FocusNode? nextFocusNode;
  TextEditingController controller = TextEditingController(text: '0');

  void onTap() {
    if(controller.text == '0') {
      controller.text = '';
    }
  }

  void onLostFocus() {
    if(controller.text == '') {
      controller.text = '0';
    }
  }

  void onFocus() {
    if(controller.text == '0') {
      controller.text = '';
    }
  }

  void onChanged(String? value) {
    if(controller.text != '') {
      if(nextFocusNode != null) {
        nextFocusNode!.requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onLostFocus();
      } else {
        onFocus();
      }
    });

    return Container(
      width: 45,
      color: isOrange ? KWTheme().alertColor : KWTheme().textColor,
      child: TextField(
        maxLength: 1,
        focusNode: focusNode,
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
            color: KWTheme().backgroundColor,
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: isOrange ? KWTheme().alertColor : KWTheme().textColor,
          border: InputBorder.none,
          counterText: '',
        ),
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }
}