import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorPickerCubit extends Cubit<Color> {
  ColorPickerCubit() : super(Colors.black); // Default color is black

  // Method to select a new color
  void selectColor(Color color) {
    emit(color);
  }
}
