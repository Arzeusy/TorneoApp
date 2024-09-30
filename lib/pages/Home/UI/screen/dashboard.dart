import 'package:flutter/material.dart';
import 'package:myapp/pages/Home/model/techiniqueModel.dart';
import 'package:myapp/pages/Home/repository/fighterService.dart';
import 'package:rive/rive.dart';
import 'package:myapp/pages/Home/widget/dashboard_appbar.dart';
import 'package:myapp/shared/widget/section.dart';
import 'package:myapp/shared/components/widget_menu.dart';
import 'package:myapp/shared/function/rive_utils.dart';
import 'package:myapp/shared/widget/menu_btn.dart';
import 'package:myapp/pages/Home/widget/card_list.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({
    super.key,
  });

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late SMIBool isSideBarClosed;
  late List<categoryModel> categoriesList = [];
  bool isSideMenuClosed = true;

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

    final result = FightersService().categoryList().then((value) {
      setState(() {
        categoriesList = value; // Actualiza el estado con los datos recibidos
      });
    });
    print('result: $result');
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

  @override
  Widget build(BuildContext context) {
    return MenuWidget(
      isSideMenuClosed: isSideMenuClosed,
      animation: animation,
      scalAnimation: scalAnimation,
      press: clickMenu,
      screen: Scaffold(
          body: SingleChildScrollView(
              child: Column(
        children: [
          DashboardAppbar(
            appbartitle: "Dash Board",
            backgroundColor: Colors.transparent,
            button: MenuBtn(
              riveOnInit: riveInit,
              press: clickMenu,
            ),
          ),
          SectionWidget(
              titleSection: "Categories",
              component: categoriesList.isEmpty
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Muestra un indicador de carga
                  : CardList(categories: categoriesList)),
          const SectionWidget(titleSection: "Statistics", component: Text(" ")),
        ],
      ))),
    );
  }
}
