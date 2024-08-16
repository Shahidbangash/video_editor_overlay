import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_editor_overlay/models/video_player_state.dart';
import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';
import 'package:video_editor_overlay/views/editing_overlay/editing_overlay_plugin.dart';
import 'package:video_editor_overlay/views/gallery/cubit/video_player_cubit.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';
import 'package:video_player/video_player.dart';
import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';
// import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

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
  GlobalKey<State<StatefulWidget>> screenshotKey = GlobalKey();
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

          final CurveDrawingCubit curveDrawingCubit =
              context.read<CurveDrawingCubit>();
          final DraggableTextCubit draggableTextCubit =
              context.read<DraggableTextCubit>();
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - kToolbarHeight - 100,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(controller),
                Container(
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight - 100,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: BlocBuilder<EditingModeCubit, EditingMode>(
                    // bloc: ,
                    builder: (context, EditingMode state) {
                      return RepaintBoundary(
                        child: Stack(
                          key: screenshotKey,
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
                        ),
                      );
                    },
                  ),
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
                if ((curveDrawingCubit.state.isNotEmpty ||
                        draggableTextCubit.state != null) &&
                    !isEditing)
                  Positioned(
                    top: 20,
                    left: 20,
                    child: FloatingActionButton(
                      onPressed: () async {
                        // RenderObject? boundary =
                        //     screenshotKey.currentContext?.findRenderObject();

                        // if (boundary == null) {
                        //   return;
                        // }
                        // boundary = boundary as RenderRepaintBoundary;

                        RenderObject? renderObject = screenshotKey
                            .currentContext
                            ?.findRenderObject()
                            ?.parent;

                        if (renderObject == null) {
                          return;
                        }
                        renderObject = renderObject as RenderRepaintBoundary;

                        ui.Image image = await renderObject.toImage();

                        ByteData? byteData = await image.toByteData(
                            format: ui.ImageByteFormat.png);

                        Uint8List pngBytes = byteData!.buffer.asUint8List();
                        log('PNG Bytes : $pngBytes');
                        if (context.mounted) {
                          // setState(() {});
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Image Preview'),
                                content: Image.memory(pngBytes),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        // Uint8List pngBytes = byteData.buffer.asUint8List();
                        // print(pngBytes);
                        // var filePath =
                        //     await ImagePickerSaver.saveFile(fileData: pngBytes);
                        // print(filePath);
                      },
                      child: Icon(
                        Icons.share,
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
