import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';
import '../util/input_formatters.dart';

class RacunkoTextField extends StatelessWidget {
  final TextEditingController textController;
  final String? hintText;
  final Function(String value) onChanged;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool isCurrency;
  final bool obscureText;
  final int verticalPadding;

  const RacunkoTextField({
    required this.textController,
    required this.onChanged,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.name,
    this.isCurrency = true,
    this.obscureText = false,
    this.verticalPadding = 12,
  });

  OutlineInputBorder border(BuildContext context) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: context.colors.text,
          width: 2,
        ),
      );

  @override
  Widget build(BuildContext context) => TextField(
        controller: textController,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.colors.background,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: verticalPadding.toDouble(),
          ),
          border: border(context),
          errorBorder: border(context),
          enabledBorder: border(context),
          focusedBorder: border(context),
          disabledBorder: border(context),
          focusedErrorBorder: border(context),
          hintText: hintText,
          hintStyle: context.textStyles.hintText,
        ),
        cursorColor: context.colors.text,
        cursorRadius: const Radius.circular(16),
        cursorWidth: 2.5,
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
        obscureText: obscureText,
        textInputAction: textInputAction,
        keyboardType: isCurrency
            ? const TextInputType.numberWithOptions(
                decimal: true,
              )
            : textInputType,
      );
}
