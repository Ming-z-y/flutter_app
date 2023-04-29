import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<String?> crop_image({
  required BuildContext context,
  required String sourcePath,
  required int maxHeight,
  required int maxWidth,
  CropStyle cropStyle = CropStyle.rectangle,
}) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: sourcePath,
    aspectRatio: const CropAspectRatio(ratioX: 329, ratioY: 190),
    maxHeight: maxHeight,
    maxWidth: maxWidth,
    cropStyle: cropStyle,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: '裁剪照片',
        toolbarColor: Colors.white,
        toolbarWidgetColor: const Color.fromRGBO(65, 53, 85, 1),
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: '裁剪照片',
      ),
    ],
  );
  return croppedFile?.path;
}
