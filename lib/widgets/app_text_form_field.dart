import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final bool? autoCorrectBool;
  final bool? obsecureBool;
  final int? max;
  final Function(String)? onChanged;

  // final TextEditingController controller;
  // final String? Function(String?)? validator;
  final String label;
  final String hint;

  const AppTextFormField({
    required this.controller,
    required this.validator,
    required this.label,
    required this.hint,
    required this.textInputType,
    required this.textInputAction,
    this.autoCorrectBool,
    this.obsecureBool,
    this.max,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: 1,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: autoCorrectBool ?? false,
      maxLength: max,
      obscureText: obsecureBool ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}
