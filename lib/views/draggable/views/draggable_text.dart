// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';

// class DraggableText extends StatefulWidget {
//   const DraggableText({super.key});

//   @override
//   State<DraggableText> createState() => _DraggableTextState();
// }

// class _DraggableTextState extends State<DraggableText> {
//   Offset offset = const Offset(100, 100);
//   double textSize = 20.0;
//   bool isEditing = false;
//   String text = 'Draggable Text';
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _controller.text = text;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ColorPickerCubit, Color>(
//       builder: (context, state) {
//         return Stack(
//           children: [
//             Positioned(
//               left: offset.dx,
//               top: offset.dy,
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   setState(() {
//                     offset = Offset(offset.dx + details.delta.dx,
//                         offset.dy + details.delta.dy);
//                   });
//                 },
//                 onDoubleTap: () {
//                   setState(() {
//                     isEditing = true;
//                   });
//                   _controller.selection = TextSelection(
//                     baseOffset: 0,
//                     extentOffset: _controller.text.length,
//                   );
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 4,
//                         offset: Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                   child: isEditing
//                       ? SizedBox(
//                           width: 200, // Adjust the width as needed
//                           child: TextField(
//                             controller: _controller,
//                             autofocus: true,
//                             onSubmitted: (newValue) {
//                               setState(() {
//                                 text = newValue;
//                                 isEditing = false;
//                               });
//                             },
//                             onEditingComplete: () {
//                               setState(() {
//                                 text = _controller.text;
//                                 isEditing = false;
//                               });
//                             },
//                             style: TextStyle(
//                               fontSize: textSize,
//                               color: Colors.black,
//                             ),
//                           ),
//                         )
//                       : Text(
//                           text,
//                           style: TextStyle(
//                             fontSize: textSize,
//                             color: state,
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/models/draggable_text_state.dart';

import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';

class DraggableText extends StatelessWidget {
  const DraggableText({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return BlocBuilder<DraggableTextCubit, DraggableTextState>(
      builder: (context, state) {
        controller.text = state.text;
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: state.text.length,
        );
        return Stack(
          children: [
            Positioned(
              left: state.offset.dx,
              top: state.offset.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  context
                      .read<DraggableTextCubit>()
                      .updatePosition(state.offset + details.delta);
                },
                onDoubleTap: () {
                  context.read<DraggableTextCubit>().toggleEditingMode(true);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: state.isEditing
                      ? SizedBox(
                          width: 200, // Adjust the width as needed
                          child: TextField(
                            controller: controller,
                            autofocus: true,
                            onSubmitted: (newValue) {
                              context
                                  .read<DraggableTextCubit>()
                                  .updateText(newValue);
                            },
                            onEditingComplete: () {
                              context
                                  .read<DraggableTextCubit>()
                                  .updateText(controller.text);
                            },
                            style: TextStyle(
                              fontSize: state.textSize,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : BlocBuilder<ColorPickerCubit, Color>(
                          builder: (context, colorState) {
                            return Text(
                              state.text,
                              style: TextStyle(
                                fontSize: state.textSize,
                                color: colorState,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
