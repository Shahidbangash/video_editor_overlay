import 'package:video_player/video_player.dart';

class VideoPlayerState {
  final VideoPlayerController? controller;
  final bool isInitialized;

  VideoPlayerState({
    this.controller,
    this.isInitialized = false,
  });

  VideoPlayerState copyWith({
    VideoPlayerController? controller,
    bool? isInitialized,
  }) {
    return VideoPlayerState(
      controller: controller ?? this.controller,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}
