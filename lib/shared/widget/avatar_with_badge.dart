import 'package:flutter/material.dart';

class AvatarWithBadge extends StatelessWidget {
  final String avatarUrl;
  final int rank;

  const AvatarWithBadge({
    super.key,
    required this.avatarUrl,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(avatarUrl),
              fit: BoxFit.cover,
              alignment:
                  Alignment.topCenter, // Alinea la imagen a la parte superior
            ),
          ),
        ),
        if (rank == 1)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star, size: 15, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
