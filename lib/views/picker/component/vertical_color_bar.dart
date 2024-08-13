import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';

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
    final ColorPickerCubit colorPickerCubit = context.read<ColorPickerCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () {
            colorPickerCubit.selectColor(color);
          },
          child: Container(
            width: 50,
            height: 40,
            color: color,
          ),
        );
      }).toList(),
    );
  }
}
