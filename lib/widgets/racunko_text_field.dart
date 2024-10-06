import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';
import '../util/input_formatters.dart';

class RacunkoTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String value) onChanged;
  final TextInputAction textInputAction;
  final bool isCurrency;

  const RacunkoTextField({
    required this.textController,
    required this.hintText,
    required this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.isCurrency = true,
  });

  @override
  Widget build(BuildContext context) => TextField(
        controller: textController,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          hintStyle: context.textStyles.hintText,
        ),
        cursorColor: context.colors.darkBlue,
        cursorRadius: const Radius.circular(8),
        cursorWidth: 2.5,
        keyboardType: isCurrency
            ? const TextInputType.numberWithOptions(
                decimal: true,
              )
            : TextInputType.name,
        inputFormatters: isCurrency
            ? [
                FilteringTextInputFormatter.allow(currencyRegEx),
                const TextInputFormatter.withFunction(
                  currencyInputFormatter,
                ),
              ]
            : null,
        onChanged: onChanged,
        style: context.textStyles.inputText,
        textAlign: TextAlign.center,
        textInputAction: textInputAction,
      );
}
