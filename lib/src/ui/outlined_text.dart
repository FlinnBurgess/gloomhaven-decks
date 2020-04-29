import 'package:flutter/cupertino.dart';

class OutlinedText extends StatelessWidget {
  Color bodyColour;
  Color outlineColour;
  String text;
  TextAlign alignment;

  OutlinedText(this.text, this.bodyColour, this.outlineColour,
      [this.alignment = TextAlign.start]);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          text,
          textAlign: alignment,
          style: TextStyle(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = outlineColour),
        ),
        Text(
          text,
          textAlign: alignment,
          style: TextStyle(color: bodyColour),
        )
      ],
    );
  }
}
