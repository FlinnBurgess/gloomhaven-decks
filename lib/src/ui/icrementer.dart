import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

class Incrementer extends StatefulWidget {
  final String label;
  final Function incrementBehaviour;
  final Function incrementEnabledCondition;
  final Function decrementBehaviour;
  final Function decrementEnabledCondition;
  final Function valueCalculation;

  Incrementer(
      {this.label,
      this.incrementBehaviour,
      this.incrementEnabledCondition,
      this.decrementBehaviour,
      this.decrementEnabledCondition,
      this.valueCalculation})
      : assert(incrementBehaviour != null),
        assert(decrementBehaviour != null),
        assert(valueCalculation != null);

  @override
  State<StatefulWidget> createState() => IncrementerState();
}

class IncrementerState extends State<Incrementer> {
  @override
  Widget build(BuildContext context) {
    IconButton decrementButton = IconButton(
      icon: Icon(
        Icons.remove,
        color: Colors.white,
      ),
      onPressed: () => this.widget.decrementEnabledCondition == null ||
              this.widget.decrementEnabledCondition()
          ? setState(() {
              this.widget.decrementBehaviour();
            })
          : null,
    );

    var incrementButton = IconButton(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => this.widget.incrementEnabledCondition == null ||
                this.widget.incrementEnabledCondition()
            ? setState(() {
                this.widget.incrementBehaviour();
              })
            : null);

    return Column(
      children: <Widget>[
        OutlinedText.blackAndWhite(this.widget.label),
        Row(
          children: <Widget>[
            decrementButton,
            OutlinedText.blackAndWhite(
                this.widget.valueCalculation().toString()),
            incrementButton
          ],
        )
      ],
    );
  }
}
