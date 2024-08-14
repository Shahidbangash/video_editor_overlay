import 'package:flutter/material.dart';

class DraggableTextState {
  final Offset offset;
  final double textSize;
  final bool isEditing;
  final String text;

  DraggableTextState({
    required this.offset,
    required this.textSize,
    required this.isEditing,
    required this.text,
  });

  DraggableTextState copyWith({
    Offset? offset,
    double? textSize,
    bool? isEditing,
    String? text,
  }) {
    return DraggableTextState(
      offset: offset ?? this.offset,
      textSize: textSize ?? this.textSize,
      isEditing: isEditing ?? this.isEditing,
      text: text ?? this.text,
    );
  }
}
