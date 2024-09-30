import 'package:myapp/shared/function/routes_function.dart';
import 'package:flutter/material.dart';
import './routes/route_home.dart';

final List<Map<String, WidgetBuilder>> allRouteMaps = [
  HomeRoutes.getRoutes(),
];

final Map<String, WidgetBuilder> combinedRoutes =
    combineRouteMaps(allRouteMaps);

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settisngs) {
    final String? name = settisngs.name;
    final WidgetBuilder? builder = combinedRoutes[name!];
    return MaterialPageRoute(builder: (context) => builder!(context));
  }
}
