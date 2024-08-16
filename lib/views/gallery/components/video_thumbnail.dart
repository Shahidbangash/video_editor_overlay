import 'package:flutter/material.dart';
import 'package:video_editor_overlay/models/video_player_state.dart';
import 'package:video_editor_overlay/views/editing_overlay/editing_overlay_plugin.dart';
import 'package:video_editor_overlay/views/gallery/cubit/video_player_cubit.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';
import 'package:video_player/video_player.dart';
import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';

class ButterFlyAssetVideo extends StatefulWidget {
  const ButterFlyAssetVideo({
    super.key,
    this.assetPath,
  });
  final String? assetPath;

  @override
  State<ButterFlyAssetVideo> createState() => _ButterFlyAssetVideoState();
}

class _ButterFlyAssetVideoState extends State<ButterFlyAssetVideo> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoPlayerCubit()
        ..initializeVideo(
          widget.assetPath ?? 'assets/videos/food_video1.mov',
        ),
      child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          if (!state.isInitialized) {
            return const CircularProgressIndicator(); // Show loading indicator
          }

          final controller = state.controller;

          // controller!.pause();
          if (controller == null) {
            return const SizedBox();
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - kToolbarHeight - 100,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(controller),
                BlocBuilder<EditingModeCubit, EditingMode>(
                  // bloc: ,
                  builder: (context, state) {
                    return Stack(
                      children: [
                        // if (state == EditingMode.textDrag)
                        // if (state == EditingMode.curveDraw)
                        DrawCurveOverlay(
                          isViewOnly: !isEditing,
                        ), // Custom Painter for drawing lines
                        DraggableText(
                          isViewOnly: !isEditing,
                        ),
                        if (isEditing) ...[
                          const ColorPickerOverlay(), // Color picker
                          const Positioned(
                            right: 4,
                            top: 80,
                            child: EditingModeOverlay(),
                          )
                        ], // Editing mode selector
                      ],
                    );
                  },
                ),
                _ControlsOverlay(controller: controller),
                VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                ),
                if (!controller.value.isPlaying)
                  Positioned(
                    top: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        controller.pause();

                        Future.delayed(
                          const Duration(milliseconds: 500),
                          () async {
                            if (isEditing) {
                              isEditing = !isEditing;
                              setState(() {});
                              return;
                            }
                            if (controller.value.isPlaying) {
                              await controller.pause();
                            }

                            if (context.mounted) {
                              setState(() {
                                isEditing = !isEditing;
                              });
                            }
                          },
                        );
                        return;
                      },
                      child: Icon(
                        (isEditing) ? Icons.close : Icons.edit,
                        size: 25,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const _ControlsOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: MaterialButton(
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        minWidth: 50,
        onPressed: () {
          controller.value.isPlaying ? controller.pause() : controller.play();
        },
        child: Stack(
          children: <Widget>[
            if (!controller.value.isPlaying)
              const Icon(
                Icons.play_arrow,
                size: 50,
                color: Colors.white,
              )
            else
              const Icon(
                Icons.stop,
                size: 50,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
