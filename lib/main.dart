import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/common/constants.dart';
import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';

import 'components/editing_mode/editing_mode_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ColorPickerCubit()),
        BlocProvider(create: (_) => EditingModeCubit()),
        BlocProvider(create: (_) => DraggableTextCubit()),
      ],
      child: MaterialApp(
        title: 'Video Editor',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Video Editor'),
          ),
          body: BlocBuilder<EditingModeCubit, EditingMode>(
            // bloc: ,
            builder: (context, state) {
              return Stack(
                children: [
                  if (state == EditingMode.textDrag) const DraggableText(),
                  if (state == EditingMode.curveDraw)
                    const DrawCurveOverlay(), // Custom Painter for drawing lines

                  const ColorPickerOverlay(), // Color picker
                  const EditingModeOverlay(), // Editing mode selector
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
