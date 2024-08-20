import 'package:flutter/material.dart';

class TimeInputField extends StatelessWidget {
  final String label;
  final double width;
  final TextEditingController controller;
  final void Function(String) onChanged;

  const TimeInputField({
    super.key,
    required this.label,
    this.width = 50,
    required this.controller,
    required this.onChanged,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,   
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            onChanged: onChanged,    
          ),
        ),
        const SizedBox(height: 5,),
        Text(label),
      ],
    );
  }
}