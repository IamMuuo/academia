import 'package:flutter/material.dart';

class GPAINFO extends StatefulWidget {
  const GPAINFO({super.key});

  @override
  State<GPAINFO> createState() => _GPAINFOState();
}

class _GPAINFOState extends State<GPAINFO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(
                Icons.favorite,
                size: 30,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '1.0',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            'Your GPA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
