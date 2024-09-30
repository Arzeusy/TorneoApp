import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/Home/model/techiniqueModel.dart';
import 'package:myapp/pages/Home/repository/fighterService.dart';
import 'package:myapp/pages/fighter/UI/fighter_profile.dart';
import 'package:myapp/pages/fighter/components/fighters_card.dart';
import 'package:myapp/pages/fighter/model/fighter_model.dart';
import 'package:myapp/shared/widget/full_screen_modal.dart';
import 'package:rive/rive.dart';
import 'package:myapp/pages/Home/widget/dashboard_appbar.dart';
import 'package:myapp/shared/components/widget_menu.dart';
import 'package:myapp/shared/function/rive_utils.dart';
import 'package:myapp/shared/widget/menu_btn.dart';

class FighterPage extends StatefulWidget {
  const FighterPage({
    super.key,
  });

  @override
  State<FighterPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<FighterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late SMIBool isSideBarClosed;

  bool isSideMenuClosed = true;

  late List<FighterModel> listaPeleadores = [];
  late List<categoryModel> categoriesList = [];
  late FighterModel selectedFighter;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    super.initState();

    FightersService().ListFighters().then((value) {
      setState(() {
        listaPeleadores = value; // Actualiza el estado con los datos recibidos
      });
    });

    FightersService().categoryList().then((value) {
      setState(() {
        categoriesList = value; // Actualiza el estado con los datos recibidos
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void clickMenu() {
    isSideBarClosed.value = !isSideMenuClosed;

    if (isSideMenuClosed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      isSideMenuClosed = isSideBarClosed.value;
    });
  }

  void riveInit(artboard) {
    StateMachineController controller = RiveUtils.getRiveController(artboard,
        stateMachineName: "State Machine");
    isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
    // Now it's easy to understand
    isSideBarClosed.value = true;
  }

  void updateFighterList(int id) {
    FightersService().ListFighters().then((value) {
      setState(() {
        listaPeleadores = value; // Actualiza el estado con los datos recibidos
        Navigator.pop(context);
        /* selectedFighter = value.firstWhere((a) => a.id == id); */
        _showFullScreenModal(context, value.firstWhere((a) => a.id == id));
      });
    });
  }

  void _showFullScreenModal(BuildContext context, FighterModel item) async {
    final result = await FightersService().listTechnique();
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return FullScreenCupertinoModal(
            title: "Fighter´s Profile",
            content: FighterProfilePage(
              fighter: item,
              categoriesList: categoriesList,
              techniques: result,
              updateFighterList: updateFighterList,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MenuWidget(
      isSideMenuClosed: isSideMenuClosed,
      animation: animation,
      scalAnimation: scalAnimation,
      press: clickMenu,
      screen: Scaffold(
          body: Column(
        children: [
          DashboardAppbar(
            backgroundColor: Colors.transparent,
            appbartitle: "Fighters",
            button: MenuBtn(
              riveOnInit: riveInit,
              press: clickMenu,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: listaPeleadores.isEmpty
                    ? [
                        const Center(child: CircularProgressIndicator())
                      ] // Muestra un indicador de carga
                    : List.generate(
                        listaPeleadores.length,
                        (index) {
                          final item = listaPeleadores[index];
                          return GestureDetector(
                            onTap: () {
                              print('Tapped on ${item.name}');
                              /* setState(() {
                                selectedFighter = item;
                              }); */
                              _showFullScreenModal(context, item);
                            },
                            child: FighterCard(user: item),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
