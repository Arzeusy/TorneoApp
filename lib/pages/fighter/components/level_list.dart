import 'package:flutter/cupertino.dart';
import 'package:myapp/pages/Home/model/techiniqueModel.dart';
import 'package:myapp/pages/fighter/components/fighter_level_card.dart';
import 'package:myapp/pages/fighter/model/fighter_model.dart';
import 'package:myapp/pages/fighter/model/techniques_model.dart';
import 'package:flutter/material.dart';
import 'package:myapp/shared/widget/chip.dart';

class LevelList extends StatelessWidget {
  final int? idCategory;
  final FighterModel fighter;
  final List<categoryModel> categoriesList;
  final List<techniquesModel> techniques;
  final Function updateFighterList;

  const LevelList(
      {super.key,
      required this.idCategory,
      required this.fighter,
      required this.categoriesList,
      required this.techniques,
      required this.updateFighterList});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(techniques.length, (index) {
      final item = techniques[index];
      final found = fighter.level.firstWhere((a) => a.techniqueID == item.id,
          orElse: () => LevelModel(power: 0, techniqueID: item.id));
      if (idCategory != null && item.categoryId != idCategory) {
        return Container();
      }

      return LevelFighterCard(
        idtechnique: item.id,
        figterID: fighter.id,
        totalStars: found.power,
        updateFighterList: updateFighterList,
        chips: [
          CustomChip(
              label: item.category,
              backgroundColor: Color(int.parse(item.categoryColor, radix: 16))),
          CustomChip(
              label: item.name,
              backgroundColor:
                  Color(int.parse(item.techniqueColor, radix: 16))),
        ],
        date: found.createdAt == null
            ? ""
            : found.createdAt.toString().substring(0, 10),
      );
    }));
  }
}
