import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:video_editor_overlay/models/path_with_color.dart';

class CurveDrawingCubit extends Cubit<List<PathWithColor>> {
  CurveDrawingCubit() : super([]);

  List<Offset> currentPath = [];

  void startPath(Offset startPoint, Color color) {
    currentPath = [startPoint];
  }

  void updatePath(Offset newPoint) {
    currentPath.add(newPoint);
    emit(List.from(state)); // Re-emit the same state to trigger an update
  }

  void endPath(Color color) {
    emit(List.from(state)..add(PathWithColor(path: currentPath, color: color)));
    currentPath = [];
  }

  void undoLastPath() {
    if (state.isNotEmpty) {
      emit(List.from(state)..removeLast());
    }
  }
}
