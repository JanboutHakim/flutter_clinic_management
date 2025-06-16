import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DatePickerField extends StatefulWidget {
  DateTime? sellectedDate;
  DatePickerField({super.key, required this.sellectedDate});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  bool _dateValid = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      decoration: InputDecoration(
        labelText:
            widget.sellectedDate == null
                ? 'Date of Birth*'
                : widget.sellectedDate.toString(),
        suffixIcon: const Icon(Icons.calendar_today),
        hintText:
            widget.sellectedDate == null
                ? 'Pick a date'
                : widget.sellectedDate!.toIso8601String(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _dateValid ? Colors.green : Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _dateValid ? Colors.green : Colors.blue,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: const TextStyle(color: Colors.red),
      ),
      validator: (value) {
        _dateValid = widget.sellectedDate == null;
        if (_dateValid) {
          return 'Date of birth is required';
        }
        return null;
      },
      onTap: () async {
        final DateTime? date = await showDatePicker(
          initialDate: DateTime.now(),
          context: context,
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          setState(() {
            widget.sellectedDate = date;
            _dateValid = true;
          });
        } else {
          setState(() {
            _dateValid = false;
            widget.sellectedDate = null;
          });
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select your date of birth')),
          );
        }
      },
    );
  }
}
