import 'package:flutter/material.dart';
import 'package:myapp/pages/Home/model/techiniqueModel.dart';
import 'package:myapp/pages/fighter/components/fighter_avatar_card.dart';
import 'package:myapp/pages/fighter/components/level_list.dart';
import 'package:myapp/pages/fighter/components/techniques_list.dart';
import 'package:myapp/pages/fighter/model/fighter_model.dart';
import 'package:myapp/pages/fighter/model/techniques_model.dart';
import 'package:myapp/shared/widget/section.dart';

class FighterProfilePage extends StatefulWidget {
  final FighterModel fighter;
  final List<categoryModel> categoriesList;
  final List<techniquesModel> techniques;
  final Function updateFighterList;

  const FighterProfilePage(
      {super.key,
      required this.fighter,
      required this.categoriesList,
      required this.techniques,
      required this.updateFighterList});

  @override
  State<FighterProfilePage> createState() => _FighterProfilePageState();
}

class _FighterProfilePageState extends State<FighterProfilePage> {
  late int? idCategory = null;

  @override
  void initState() {
    super.initState();
  }

  void filterByCategory(int newCategory) {
    setState(() {
      if (idCategory == newCategory) {
        idCategory = null;
      } else {
        idCategory = newCategory;
      }
    });
  }

  void updateFighter() {
    widget.updateFighterList(widget.fighter.id);
  }

  @override
  void didUpdateWidget(FighterProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvatarCard(
          avatarUrl: widget.fighter.avatarUrl,
          name: '${widget.fighter.name} ${widget.fighter.lastName}',
          subtitle:
              '${widget.fighter.level.fold(0.0, (sum, item) => sum + item.power)} stars',
        ),
        SectionWidget(
            titleSection: "",
            component: TechniqueList(
              categories: widget.categoriesList,
              press: filterByCategory,
              idCategory: idCategory,
            )),
        const Padding(
          padding: EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 5.0),
          child: Text(
            "Level",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 0.0),
                    child: LevelList(
                      categoriesList: widget.categoriesList,
                      techniques: widget.techniques,
                      idCategory: idCategory,
                      fighter: widget.fighter,
                      updateFighterList: updateFighter,
                    ))))
      ],
    );
  }
}
