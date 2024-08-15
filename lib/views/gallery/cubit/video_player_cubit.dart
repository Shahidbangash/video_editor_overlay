import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/models/video_player_state.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerState());

  void initializeVideo(String assetPath) async {
    final controller = VideoPlayerController.asset(assetPath);
    await controller.initialize();
    controller.setLooping(true);
    controller.play();
    emit(state.copyWith(controller: controller, isInitialized: true));

    controller.addListener(() {
      emit(state.copyWith()); // Emit the updated state to trigger UI rebuild
    });
  }

  @override
  Future<void> close() {
    state.controller?.dispose();
    return super.close();
  }
}
