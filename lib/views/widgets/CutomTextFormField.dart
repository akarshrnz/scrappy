import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final String? label;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
    final FormFieldValidator<String>? validator;


  const CustomTextField({
    super.key,
    this.label,
    this.title,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    required this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: labelStyle ?? const TextStyle(color: Colors.white, fontSize: 14),
          ),
        if (title != null) const SizedBox(height: 6),
        TextFormField(
                    validator: validator,

            cursorColor: Colors.white,
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText,
          enabled: enabled,
          
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            labelText: label,
            
            labelStyle: labelStyle??const TextStyle(color: Colors.white70),
            hintStyle: hintStyle ?? const TextStyle(color: Colors.white),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6),
            ),
            filled: false,
          ),
        ),
      ],
    );
  }
}
