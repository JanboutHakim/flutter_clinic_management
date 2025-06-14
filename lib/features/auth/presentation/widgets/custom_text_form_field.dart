import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isValid = false;

  String? _validate(String? value) {
    final res = widget.validator?.call(value);
    setState(() {
      _isValid = res == null;
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _isValid ? Colors.green : Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _isValid ? Colors.green : Colors.blue,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: _validate,
      onChanged: (value) {
        widget.onChanged?.call(value);
        _validate(value);
      },
    );
  }
}
