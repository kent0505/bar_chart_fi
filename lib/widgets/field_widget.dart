import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.number = false,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final bool number;
  final void Function() onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: number ? TextInputType.number : null,
      inputFormatters: [
        LengthLimitingTextInputFormatter(number
            ? controller.text.contains('.')
                ? 7
                : 6
            : 20),
        // if (number) FilteringTextInputFormatter.digitsOnly,
        if (number) ...[
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          DecimalPointInputFormatter(),
        ]
      ],
      textCapitalization: TextCapitalization.sentences,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'w600',
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black.withValues(alpha: 0.3),
          fontSize: 18,
          fontFamily: 'w600',
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.greenAccent,
            width: 2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withValues(alpha: 0.3),
          ),
        ),
      ),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: (value) {
        onChanged();
      },
    );
  }
}

class DecimalPointInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.text.split('.').length > 2 ? oldValue : newValue;
  }
}
