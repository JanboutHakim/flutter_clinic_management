import 'package:doclib/core/constants/gender_enum.dart';
import 'package:doclib/features/auth/data/models/Auth_model.dart';
import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  const GenderPicker({super.key, required this.authRequest});
  final AuthRequest authRequest;

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  bool _genderValid = false;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<GenderEnum>(
      // autovalidateMode: AutovalidateMode.always,
      value: widget.authRequest.gender ?? GenderEnum.male,
      decoration: InputDecoration(
        labelText: 'Gender',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _genderValid ? Colors.green : Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _genderValid ? Colors.green : Colors.blue,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      items:
          GenderEnum.values
              .map(
                (gender) =>
                    DropdownMenuItem(value: gender, child: Text(gender.name)),
              )
              .toList(),
      onChanged:
          (value) => setState(() {
            widget.authRequest.gender = value;
            _genderValid = value != null;
          }),
      validator: (value) {
        _genderValid = value != null;
        return value == null ? 'Required' : null;
      },
    );
  }
}
