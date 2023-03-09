import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'rounded_input_field.dart';

class RoundedDatePickerField extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final String hintText;
  final Function(DateTime)?
      onDateSelected; // <-- define the named parameter here

  RoundedDatePickerField({
    Key? key,
    required this.label,
    required this.initialDate,
    required this.hintText,
    this.onDateSelected, // <-- add the named parameter to the constructor
  }) : super(key: key);

  @override
  _RoundedDatePickerFieldState createState() => _RoundedDatePickerFieldState();
}

class _RoundedDatePickerFieldState extends State<RoundedDatePickerField> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedInputField(
      label: widget.label,
      controller: TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(_selectedDate),
      ),
      hintText: widget.hintText,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
            if (widget.onDateSelected != null) {
              // <-- check if the named parameter is not null
              widget.onDateSelected!(
                  picked); // <-- call the named parameter function with the picked date
            }
          });
        }
      },
    );
  }
}
