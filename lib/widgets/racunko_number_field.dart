import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';
import '../util/input_formatters.dart';

class RacunkoNumberField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String value) onChanged;
  final TextInputAction textInputAction;

  const RacunkoNumberField({
    required this.textController,
    required this.hintText,
    required this.onChanged,
    this.textInputAction = TextInputAction.next,
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
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(currencyRegEx),
          const TextInputFormatter.withFunction(
            currencyInputFormatter,
          ),
        ],
        onChanged: onChanged,
        style: context.textStyles.inputText,
        textAlign: TextAlign.center,
        textInputAction: textInputAction,
      );
}
