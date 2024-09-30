import 'package:myapp/pages/Home/model/techiniqueModel.dart';
import 'package:myapp/shared/widget/card.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final List<categoryModel> categories;

  const CardList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final List<StatusWidget> taskDataList = categories.map((category) {
      return StatusWidget(
        color: Color(int.parse(category.color, radix: 16)),
        title: category.name,
        subtitle: '${category.techniqueCount.toString()} techniques',
      );
    }).toList();

    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: taskDataList.length,
        itemBuilder: (context, index) {
          final taskData = taskDataList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StatusWidget(
              subtitle: taskData.subtitle,
              color: taskData.color,
              title: taskData.title,
            ),
          );
        },
      ),
    );
  }
}
