import 'package:flutter/material.dart';

class VerticalColorBar extends StatelessWidget {
  final List<Color> colors;
  final ValueChanged<Color> onColorSelected;

  const VerticalColorBar({
    super.key,
    required this.colors,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 50),
      // width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: colors.map((color) {
          return GestureDetector(
            onTap: () {
              onColorSelected(color);
            },
            child: Container(
              width: 50,
              height: 40,
              color: color,
            ),
          );
        }).toList(),
      ),
    );
  }
}
