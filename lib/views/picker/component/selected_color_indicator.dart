import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';

class SelectedColorIndicator extends StatelessWidget {
  final Color color;

  const SelectedColorIndicator({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorPickerCubit, Color>(
      builder: (context, selectedColor) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: selectedColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
        );
      },
    );
  }
}
