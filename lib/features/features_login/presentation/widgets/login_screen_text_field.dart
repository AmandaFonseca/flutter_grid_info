import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final void Function(String)? onChanged;
  final String? Function()? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool isPassword;
  final VoidCallback? onSuffixIconPressed;

  const CustomTextField({
    super.key,
    required this.label,
    this.onChanged,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.isPassword = false,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          errorText: errorText?.call(),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: onSuffixIconPressed,
                )
              : null,
        ),
      ),
    );
  }
}
