import 'package:flutter/material.dart';

class TimeInputField extends StatelessWidget {
  final String label;
  final String initialValue;
  final double width;

  const TimeInputField({
    super.key,
    required this.label,
    required this.initialValue,
    this.width = 50,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width,
          child: TextFormField(
            initialValue: initialValue,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            ),    
          ),
        ),
        const SizedBox(height: 5,),
        Text(label),
      ],
    );
  }
}