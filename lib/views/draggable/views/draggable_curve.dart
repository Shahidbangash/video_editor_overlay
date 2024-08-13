import 'package:flutter/material.dart';

class DrawCurveOverlay extends StatefulWidget {
  const DrawCurveOverlay({super.key});

  @override
  State<DrawCurveOverlay> createState() => _DrawCurveOverlayState();
}

class _DrawCurveOverlayState extends State<DrawCurveOverlay> {
  List<List<Offset>> paths = []; // List of paths, each path is a list of points
  List<Offset> currentPath = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          currentPath = [details.localPosition];
        });
      },
      onPanUpdate: (details) {
        setState(() {
          currentPath.add(details.localPosition);
        });
      },
      onPanEnd: (details) {
        setState(() {
          paths.add(currentPath);
          currentPath = [];
        });
      },
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: CurvePainter(paths: paths),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: FloatingActionButton(
              onPressed: _undoLastPath,
              child: const Icon(Icons.undo),
            ),
          ),
        ],
      ),
    );
  }

  void _undoLastPath() {
    setState(() {
      if (paths.isNotEmpty) {
        paths.removeLast();
      }
    });
  }
}

class CurvePainter extends CustomPainter {
  final List<List<Offset>> paths;

  final Color color;
  final double strokeWidth;

  CurvePainter({
    required this.paths,
    this.color = Colors.blue,
    this.strokeWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (var pathPoints in paths) {
      if (pathPoints.isNotEmpty) {
        Path path = Path();
        path.moveTo(pathPoints[0].dx, pathPoints[0].dy);

        for (int i = 1; i < pathPoints.length; i++) {
          path.lineTo(pathPoints[i].dx, pathPoints[i].dy);
        }

        canvas.drawPath(path, paint);
      }
    }

    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
