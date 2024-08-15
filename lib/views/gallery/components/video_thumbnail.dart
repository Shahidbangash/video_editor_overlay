import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/models/video_player_state.dart';
import 'package:video_editor_overlay/views/gallery/cubit/video_player_cubit.dart';
import 'package:video_player/video_player.dart';

class ButterFlyAssetVideo extends StatelessWidget {
  const ButterFlyAssetVideo({
    super.key,
    this.assetPath,
  });
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoPlayerCubit()
        ..initializeVideo(
          assetPath ?? 'assets/videos/food_video1.mov',
        ),
      child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          if (!state.isInitialized) {
            return const CircularProgressIndicator(); // Show loading indicator
          }

          final controller = state.controller;

          return Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(controller),
                  _ControlsOverlay(controller: controller),
                  VideoProgressIndicator(
                    controller,
                    allowScrubbing: true,
                  ),
                ],
              ),
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
