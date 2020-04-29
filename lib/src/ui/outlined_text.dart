import 'package:flutter/cupertino.dart';

class OutlinedText extends StatelessWidget {
  Color bodyColour;
  Color outlineColour;
  String text;

  OutlinedText(this.text, this.bodyColour, this.outlineColour);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = outlineColour),
        ),
        Text(
          text,
          style: TextStyle(color: bodyColour),
        )
      ],
    );
  }
}
