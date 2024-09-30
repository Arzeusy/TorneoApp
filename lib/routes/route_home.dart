import 'package:flutter/material.dart';
import 'package:myapp/pages/Home/UI/screen/dashboard.dart';
import 'package:myapp/pages/Home/home.dart';
import 'package:myapp/pages/fighter/UI/fighter_page.dart';
import '../shared/function/routes_function.dart';
import '../pages/login/UI/screens/login_page.dart';

class HomeRoutes {
  static final Map<String, WidgetBuilder> _routesMap = {
    '': (context) => const LoginPageWidget(),
    'home': (context) => const DashBoardPage(),
    'fighter': (context) => const FighterPage(),
    'Tempo': (context) => const MyHomePage(
          title: "tempo",
        )
  };

  static const String _prefix = '/';

  static Map<String, WidgetBuilder> getRoutes() {
    return addPrefixToRoutes(_routesMap, _prefix);
  }
}
