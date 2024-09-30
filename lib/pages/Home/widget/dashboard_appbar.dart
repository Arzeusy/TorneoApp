import 'package:myapp/pages/Home/widget/linear_calendar.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

class DashboardAppbar extends StatelessWidget {
  final Color backgroundColor;
  final String appbartitle;
  final Widget button;

  const DashboardAppbar({
    Key? key,
    required this.backgroundColor,
    required this.button,
    required this.appbartitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String formattedDate = DateFormat('MMMM yyyy').format(now);

    return Container(
        color: backgroundColor,
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                button,
                Text(
                  appbartitle,
                  style: const TextStyle(
                    color: Color(0xFF2F455D),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined),
                  onPressed: () {
                    LinearCalendar.globalKey.currentState?.scrollToCurrentDay();
                  },
                  color: Color(0xFF2F455D),
                ),
              ],
            ),
          ],
        ));
  }
}
