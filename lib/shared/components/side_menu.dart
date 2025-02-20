import 'package:myapp/shared/function/rive_asset.dart';
import 'package:myapp/shared/widget/info_card.dart';
import 'package:myapp/shared/widget/side_menu_tile.dart';
import 'package:flutter/material.dart';
import '../function/rive_utils.dart';
import 'package:rive/rive.dart';

// import 'package:rive_animation/models/rive_asset.dart';
// import 'package:rive_animation/utils/rive_utils.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key, required this.press}) : super(key: key);

  final VoidCallback press;

  @override
  State<SideMenu> createState() => _StateSideMenu();
}

class _StateSideMenu extends State<SideMenu> {
  final browseText = "Browse".toUpperCase();

  RiveAsset selectedMenu = sideMenus.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: 288.0,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                  title: 'Yeicob Calderon',
                  press: widget.press,
                  subTitle: '@arzeusy'),
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, top: 32.0, bottom: 16.0),
                child: Text(
                  browseText,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ...sideMenus.map((menu) => SideMenutile(
                    menu: menu,
                    riveonInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(
                        artboard,
                        stateMachineName: menu.stateMachineName,
                      );
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                    press: () {
                      menu.input!.change(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        menu.input!.change(false);
                        if (menu.route != null) {
                          Navigator.pushReplacementNamed(context, menu.route!);
                          widget.press();
                        }
                      });
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    isActive: selectedMenu == menu,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
