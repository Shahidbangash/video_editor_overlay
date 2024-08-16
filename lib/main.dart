import 'package:flutter/material.dart';
import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';
import 'package:video_editor_overlay/views/gallery/gallery_plugin.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';

import 'components/editing_mode/editing_mode_widget.dart';
import 'views/editing_overlay/editing_overlay_plugin.dart';

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
        BlocProvider(create: (_) => CurveDrawingCubit()),
        BlocProvider(create: (_) => GalleryCubit()),
      ],
      child: const MaterialApp(
        title: 'Video Editor Overlay',
        home: GalleryViewScreen(),
      ),
    );
  }
}
