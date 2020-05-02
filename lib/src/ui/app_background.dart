import 'package:flutter/cupertino.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  AppBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/backgrounds/atmospheric-dark-min.jpg'),
              fit: BoxFit.cover),
        ),
        child: child);
  }
}
