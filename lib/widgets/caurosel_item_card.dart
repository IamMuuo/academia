import 'package:flutter/material.dart';

class CauroselItemCard extends StatelessWidget {
  const CauroselItemCard({
    super.key,
    this.color = Colors.blue,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    this.icon1 = Icons.calendar_today,
    this.icon2 = Icons.location_pin,
    this.center,
  });
  final Color color;
  final String title;
  final String description;
  final IconData icon1;
  final String date;
  final IconData icon2;
  final String location;
  final Widget? center;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          center == null ? const Spacer() : center!,
          const Spacer(),
          Row(
            children: [
              Icon(
                icon1,
                color: Colors.white,
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Icon(
                icon2,
                color: Colors.white,
              ),
              Text(
                location,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
