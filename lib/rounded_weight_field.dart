import 'package:flutter/material.dart';

class RoundedWeightField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? selectedWeightUnit;
  final ValueChanged<String> onChanged;

  RoundedWeightField({
    required this.label,
    required this.controller,
    required this.onChanged,
    this.selectedWeightUnit,
  });

  @override
  _RoundedWeightFieldState createState() => _RoundedWeightFieldState();
}

class _RoundedWeightFieldState extends State<RoundedWeightField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: widget.label,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          DropdownButton<String>(
            value: widget.selectedWeightUnit,
            onChanged: (value) {
              setState(() {
                widget.onChanged(widget.controller.text + value!);
              });
            },
            items: ['kg', 'lbs'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
