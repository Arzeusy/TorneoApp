import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final int? count; // Añadimos la propiedad del número a mostrar.
  final Color? backgroundColor;
  final IconData? icon;
  final Color? iconColor;

  const CustomChip({
    super.key,
    required this.label,
    this.count, // Recibimos el número opcional.
    this.backgroundColor,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      avatar: icon != null
          ? Icon(icon, color: iconColor)
          : null, // Icono opcional en la izquierda.
      backgroundColor: backgroundColor ?? Colors.transparent,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (count != null) ...[
            const SizedBox(width: 8), // Espacio entre el label y el número.
            CircleAvatar(
              radius: 12,
              backgroundColor: iconColor, // Color de fondo del círculo.
              child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    '$count', // Mostramos el número.
                    style: const TextStyle(
                      fontSize: 12,
                      color:
                          Colors.black, // Color del texto dentro del círculo.
                    ),
                  )),
            ),
          ]
        ],
      ),
    );
  }
}
