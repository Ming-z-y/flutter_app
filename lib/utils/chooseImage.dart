import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageChoices {
  //实例化选择图片
  static final ImagePicker picker = ImagePicker();
  static getPhoneImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  static getImageFromCamera() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);
  }
}
