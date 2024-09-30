import 'package:myapp/pages/Home/model/techiniqueModel.dart';
import 'package:flutter/material.dart';
import 'package:myapp/shared/widget/chip.dart';

class TechniqueList extends StatelessWidget {
  final List<categoryModel> categories;
  final Function press;
  final int? idCategory;

  const TechniqueList(
      {super.key,
      required this.categories,
      required this.press,
      required this.idCategory});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final selectedCategory = idCategory == category.id;

          return Padding(
              padding: const EdgeInsets.all(6.0),
              child: InkWell(
                onTap: () {
                  press(category.id);
                },
                child: CustomChip(
                  label: category.name,
                  backgroundColor: !selectedCategory
                      ? Colors.transparent
                      : Color(int.parse(category.color, radix: 16)),
                  iconColor: !selectedCategory
                      ? Color(int.parse(category.color, radix: 16))
                      : Colors.white,
                  count: int.parse(category.techniqueCount.toString()),
                ),
              ));
        },
      ),
    ));
  }
}
