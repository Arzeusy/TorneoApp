import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/Home/repository/fighterService.dart';
import 'package:myapp/shared/widget/chip.dart';

class LevelFighterCard extends StatelessWidget {
  final String? title;
  final List<CustomChip> chips;
  final String date;
  final int totalStars;
  final int idtechnique;
  final int figterID;
  final Function updateFighterList;

  const LevelFighterCard(
      {super.key,
      this.title,
      required this.chips,
      required this.date,
      required this.totalStars,
      required this.idtechnique,
      required this.figterID,
      required this.updateFighterList});

  static Widget _modalBuilder(BuildContext context, Map<String, dynamic> data) {
    double _currentSliderValue = 0.0;
    int figterID = data["fighter"];
    int idtechnique = data["technique"];
    bool loader = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return CupertinoActionSheet(
          title: const Text('Power level'),
          message: loader
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Muestra un indicador de carga
              : Column(
                  children: [
                    const Text('Seleccione un valor'),
                    CupertinoSlider(
                      key: const Key('slider'),
                      value: _currentSliderValue,
                      divisions: 20,
                      max: 100,
                      activeColor: CupertinoColors.systemPurple,
                      thumbColor: CupertinoColors.systemPurple,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                    Text('Valor actual: $_currentSliderValue'),
                  ],
                ),
          actions: loader
              ? null
              : <CupertinoActionSheetAction>[
                  CupertinoActionSheetAction(
                    child: const Text('Aceptar'),
                    onPressed: () {
                      setState(() {
                        loader =
                            true; // Actualiza el estado con los datos recibidos
                      });
                      FightersService()
                          .insertLevelToFighter(
                              figterID,
                              idtechnique.toString(),
                              _currentSliderValue.toInt())
                          .then((value) {
                        Navigator.pop(
                            context, true); // Devuelve 'true' cuando se acepta
                      });
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(
                          context, false); // Devuelve 'false' cuando se cancela
                    },
                  ),
                ],
        );
      },
    );
  }

  void _openModal(BuildContext context) async {
    final bool? result = await Navigator.of(context).push(
      CupertinoModalPopupRoute<bool>(
        builder: (BuildContext context) {
          return _modalBuilder(context, {
            "fighter": figterID,
            "technique": idtechnique,
          });
        },
      ),
    );

    if (result == true) {
      updateFighterList();
    } else {
      print("Modal cancelado");
    }
  }

/*   void _openModal(BuildContext context) async {
    Navigator.of(context).restorablePush(
      _modalBuilder,
      arguments: {
        "fighter": figterID,
        "technique": idtechnique,
      },
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xff727272), width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Icon(Icons.calendar_month, color: Colors.grey),
                  Text(date, style: const TextStyle(color: Colors.grey)),
                ]),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    /* Navigator.of(context)
                        .restorablePush(_modalBuilder, arguments: {
                      "fighter": figterID,
                      "technique": idtechnique,
                    }); */
                    _openModal(context);
                  },
                ),
              ],
            ),
            SizedBox(height: title == null ? 0 : 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 8,
                  children: chips,
                ),
                _buildStarAvatars(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método que construye el grupo de avatares de estrellas
  Widget _buildStarAvatars() {
    if (totalStars > 1) {
      return Stack(
        children: [
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(1, (index) {
                  return const CircleAvatar(
                      radius: 10,
                      backgroundColor: Color.fromARGB(255, 224, 175, 29),
                      child: Icon(Icons.star,
                          color: Color.fromARGB(255, 164, 99, 15), size: 16));
                }),
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey,
                child: Text(
                  '+${totalStars - 1}',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(totalStars, (index) {
          return const CircleAvatar(
              radius: 10,
              backgroundColor: Color.fromARGB(255, 224, 175, 29),
              child: Icon(Icons.star,
                  color: Color.fromARGB(255, 164, 99, 15), size: 16));
        }),
      );
    }
  }
}
