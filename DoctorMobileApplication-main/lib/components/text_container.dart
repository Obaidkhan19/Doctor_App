import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String? text;
  final Color? color;
  const TextContainer({
    super.key,
    this.color = Colors.green,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            border: Border.all(color: color!, width: 2),
            borderRadius: BorderRadius.circular(4)),
        child: Text(
          '$text',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: color, fontSize: 12, fontWeight: FontWeight.bold),
        ));
  }
}