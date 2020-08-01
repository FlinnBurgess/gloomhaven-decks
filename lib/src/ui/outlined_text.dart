import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final Color bodyColour;
  final Color outlineColour;
  final String text;
  final TextAlign alignment;

  OutlinedText(this.text, this.bodyColour, this.outlineColour,
      [this.alignment = TextAlign.start]);

  OutlinedText.blackAndWhite(text, [alignment = TextAlign.start])
      : this(text, Colors.white, Colors.black, alignment);

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
