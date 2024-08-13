import 'package:flutter/material.dart';

class SelectedColorIndicator extends StatelessWidget {
  final Color color;

  const SelectedColorIndicator({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
      ),
    );
  }
}
