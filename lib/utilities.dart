
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:io' as io;
import 'package:flutter/services.dart';
// import 'package:platform_device_id_v3/platform_device_id.dart';

class Utilities {
  static void showSnackbar(String title, String message) {

    Get.snackbar(
      '$title',
      '$message',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      isDismissible: true,
      duration: const Duration(seconds: 5),

    );

  }
}