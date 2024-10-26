import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  static void startLoading (String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            const SizedBox(height: 250,),
            Text("Yükleniyor"),
          ]),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}