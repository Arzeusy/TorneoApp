import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;

  const StatusWidget({
    Key? key,
    required this.color,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Positioned(
            top: -5,
            right: -5,
            child: IconButton(
              icon: Icon(Icons.more_horiz, color: Colors.white),
              onPressed: () {
                // Acción del botón
              },
            ),
          ),
        ],
      ),
    );
  }
}
