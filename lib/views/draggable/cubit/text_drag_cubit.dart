import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:video_editor_overlay/models/draggable_text_state.dart';

class DraggableTextCubit extends Cubit<DraggableTextState?> {
  DraggableTextCubit()
      : super(
          null,
          // DraggableTextState(
          //   offset: const Offset(100, 100),
          //   textSize: 20.0,
          //   isEditing: false,
          //   text: 'Draggable Text',
          // ),
        );

  void updatePosition(Offset newOffset) {
    emit(state?.copyWith(offset: newOffset));
  }

  void toggleEditingMode(bool isEditing) {
    emit(state?.copyWith(isEditing: isEditing));
  }

  void updateText(String newText) {
    emit(state?.copyWith(text: newText, isEditing: false));
  }

  void updateTextSize(double newSize) {
    emit(state?.copyWith(textSize: newSize));
  }

  void initText() {
    emit(
      DraggableTextState(
        offset: const Offset(100, 100),
        textSize: 20.0,
        isEditing: false,
        text: 'Draggable Text',
      ),
    );
  }
}
