import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/common/constants.dart';
import 'package:video_editor_overlay/components/editing_mode/editing_mode_widget.dart';
import 'package:video_editor_overlay/components/editing_mode/widget/editing_mode_selector.dart';
import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';

class EditingModeOverlay extends StatelessWidget {
  const EditingModeOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topRight,
      child: EditingModeSelector(),
    );
    // return BlocProvider(
    //   // create: (_) => EditingModeCubit(),
    //   child: const Align(
    //     alignment: Alignment.topRight,
    //     child: EditingModeSelector(),
    //   ),
    // );
  }
}
