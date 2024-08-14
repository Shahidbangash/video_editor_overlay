import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/common/constants.dart';

class EditingModeCubit extends Cubit<EditingMode> {
  EditingModeCubit() : super(EditingMode.curveDraw); // Default to curve draw

  // Method to select the editing mode
  void selectMode(EditingMode mode) {
    emit(mode);
  }
}
