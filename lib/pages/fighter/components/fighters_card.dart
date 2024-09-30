import 'package:flutter/material.dart';
import 'package:myapp/pages/fighter/model/fighter_model.dart';
import 'package:myapp/shared/widget/avatar_with_badge.dart';

class FighterCard extends StatelessWidget {
  final FighterModel user;

  const FighterCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListTile(
        leading: AvatarWithBadge(
          avatarUrl: user.avatarUrl,
          rank: 1,
        ),
        title: Text('${user.name} ${user.lastName}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Ø ${user.level.length} skills'),
        trailing: Chip(
          label: Text(
              '${user.level.fold(0.0, (sum, item) => sum + item.power)} stars'),
          backgroundColor: Colors.lightGreenAccent,
        ),
      ),
    );
  }
}
