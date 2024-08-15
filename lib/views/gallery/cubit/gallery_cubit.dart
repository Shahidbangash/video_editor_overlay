import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_editor_overlay/components/editing_mode/editing_mode_widget.dart';

class GalleryCubit extends Cubit<dynamic> {
  GalleryCubit() : super(null);

  // get gallery items
  Future<void> getGalleryItems(BuildContext context) async {
    // get gallery items

    // >> To get paths you need these 2 lines
    // final dir = Directory('assets/videos');
    // final List<FileSystemEntity> entities = await dir.list().toList();

    var assetsFile =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assetsFile);

    manifestMap.forEach(
      (key, value) {
        if (key.startsWith('assets/videos/')) {
          log('Key : $key');
          log('Value : $value');
        } else {
          log('Non Video : $key');
          log('Non Video Value : $value');
        }
      },
    );

    // for (var element in manifestMap) {
    //   log('Item : ${element.parent}');
    // }
  }
}
