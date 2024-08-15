import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor_overlay/views/draggable/draggable_plugin.dart';
import 'package:video_editor_overlay/views/picker/color_picker_plugin.dart';

// class DrawCurveOverlay extends StatefulWidget {
//   const DrawCurveOverlay({super.key});

//   @override
//   State<DrawCurveOverlay> createState() => _DrawCurveOverlayState();
// }

// class _DrawCurveOverlayState extends State<DrawCurveOverlay> {
//   List<PathWithColor> pathsWithColors = []; // List of paths with their colors
//   List<Offset> currentPath = [];

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanStart: (details) {
//         setState(() {
//           currentPath = [details.localPosition];
//         });
//       },
//       onPanUpdate: (details) {
//         setState(() {
//           currentPath.add(details.localPosition);
//         });
//       },
//       onPanEnd: (details) {
//         final currentColor = context.read<ColorPickerCubit>().state;
//         setState(() {
//           pathsWithColors
//               .add(PathWithColor(path: currentPath, color: currentColor));
//           currentPath = [];
//         });
//       },
//       child: Stack(
//         children: [
//           BlocBuilder<ColorPickerCubit, Color>(
//             builder: (context, state) {
//               return CustomPaint(
//                 size: Size.infinite,
//                 painter: CurvePainter(pathsWithColors: pathsWithColors),
//               );
//             },
//           ),
//           Positioned(
//             // top: MediaQuery.of(context).size.height * 0.2,
//             // right: 20,
//             child: FloatingActionButton(
//               onPressed: _undoLastPath,
//               child: const Icon(Icons.undo),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _undoLastPath() {
//     setState(() {
//       if (pathsWithColors.isNotEmpty) {
//         pathsWithColors.removeLast();
//       }
//     });
//   }
// }

// class CurvePainter extends CustomPainter {
//   final List<PathWithColor> pathsWithColors;

//   CurvePainter({required this.pathsWithColors});

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (var pathWithColor in pathsWithColors) {
//       final paint = Paint()
//         ..color = pathWithColor.color
//         ..strokeWidth = 4.0
//         ..style = PaintingStyle.stroke;

//       final pathPoints = pathWithColor.path;

//       if (pathPoints.isNotEmpty) {
//         Path path = Path();
//         path.moveTo(pathPoints[0].dx, pathPoints[0].dy);

//         for (int i = 1; i < pathPoints.length; i++) {
//           path.lineTo(pathPoints[i].dx, pathPoints[i].dy);
//         }

//         canvas.drawPath(path, paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

class DrawCurveOverlay extends StatelessWidget {
  const DrawCurveOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        final currentColor = context.read<ColorPickerCubit>().state;
        context
            .read<CurveDrawingCubit>()
            .startPath(details.localPosition, currentColor);
      },
      onPanUpdate: (details) {
        context.read<CurveDrawingCubit>().updatePath(details.localPosition);
      },
      onPanEnd: (details) {
        final currentColor = context.read<ColorPickerCubit>().state;
        context.read<CurveDrawingCubit>().endPath(currentColor);
      },
      child: Stack(
        children: [
          BlocBuilder<CurveDrawingCubit, List<PathWithColor>>(
            builder: (context, pathsWithColors) {
              return CustomPaint(
                size: Size.infinite,
                painter: CurvePainter(pathsWithColors: pathsWithColors),
              );
            },
          ),
          Positioned(
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                context.read<CurveDrawingCubit>().undoLastPath();
              },
              child: const Icon(Icons.undo),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final List<PathWithColor> pathsWithColors;

  CurvePainter({required this.pathsWithColors});

  @override
  void paint(Canvas canvas, Size size) {
    for (var pathWithColor in pathsWithColors) {
      final paint = Paint()
        ..color = pathWithColor.color
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke;

      final pathPoints = pathWithColor.path;

      if (pathPoints.isNotEmpty) {
        Path path = Path();
        path.moveTo(pathPoints[0].dx, pathPoints[0].dy);

        for (int i = 1; i < pathPoints.length; i++) {
          path.lineTo(pathPoints[i].dx, pathPoints[i].dy);
        }

        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
