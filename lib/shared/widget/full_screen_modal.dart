import 'package:flutter/cupertino.dart';

class FullScreenCupertinoModal extends StatelessWidget {
  final Widget content;
  final String title;

  const FullScreenCupertinoModal({
    super.key,
    required this.content,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: null,
        middle: Text(title),
      ),
      child: SafeArea(
        child: content, // Aquí va el widget que quieras pasar
      ),
    );
  }
}
