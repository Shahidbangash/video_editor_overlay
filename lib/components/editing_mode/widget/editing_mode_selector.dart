import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/common/constants.dart';
import 'package:video_editor_overlay/components/editing_mode/editing_mode_widget.dart';

class EditingModeSelector extends StatelessWidget {
  const EditingModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context
                  .read<EditingModeCubit>()
                  .selectMode(EditingMode.curveDraw);
            },
            tooltip: 'Draw Curves',
            child: const Icon(Icons.brush),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              context.read<EditingModeCubit>().selectMode(EditingMode.textDrag);
            },
            tooltip: 'Drag Text',
            child: const Icon(Icons.text_fields),
          ),
        ],
      ),
    );
  }
}
