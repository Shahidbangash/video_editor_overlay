import 'package:flutter/material.dart';
import 'package:video_editor_overlay/views/gallery/gallery_plugin.dart';
// import 'package:video_editor_overlay/views/editing_overlay/editing_overlay.dart';

class GalleryViewScreen extends StatelessWidget {
  const GalleryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery View'),
      ),
      body: MaterialButton(
        onPressed: () {
          context.read<GalleryCubit>().getGalleryItems(context);
        },
        child: Column(
          children: [
            // const Center(
            //   child: Text('Gallery View'),
            // ),
            ButterFlyAssetVideo()
          ],
        ),
      ),
    );
  }
}
