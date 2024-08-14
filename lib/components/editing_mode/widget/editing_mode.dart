import 'package:flutter/material.dart';
import 'package:video_editor_overlay/components/editing_mode/editing_mode_widget.dart';
import 'package:video_editor_overlay/components/editing_mode/widget/editing_mode_selector.dart';

class EditingModeOverlay extends StatelessWidget {
  const EditingModeOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topRight,
      child: EditingModeSelector(),
    );
  }
}
