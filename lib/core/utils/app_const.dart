import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_fade/image_fade.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class AppConst{
  static Widget kheight({required double height}) => SizedBox(
        height: height,
      );
  static Widget kwidth({required double width}) => SizedBox(
        width: width,
      );

  static Widget loading() => const Center(
        child: CircularProgressIndicator(
          color: ColorConst.appColor
        ),
      );

  static toastMsg({required String msg, required Color backgroundColor}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static SnackBar ShowSnackBar(
      {required String message, required Color color}) {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      backgroundColor: color,
      elevation: 11,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
      shape: const StadiumBorder(),
      dismissDirection: DismissDirection.vertical,
    );
  }

  static Widget indicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: ColorConst.appColor,
    ));
  }

  static Widget fadImaage(
      {required String url, double? width, double? height}) {
    return ImageFade(
      // whenever the image changes, it will be loaded, and then faded in:
      image: NetworkImage(url),

      // slow fade for newly loaded images:
      duration: const Duration(milliseconds: 900),

      // if the image is loaded synchronously (ex. from memory), fade in faster:
      syncDuration: const Duration(milliseconds: 150),

      // supports most properties of Image:
      alignment: Alignment.center,
      fit: BoxFit.cover,
      height: height,
      width: width,
      // shown behind everything:
      placeholder: Shimmer(
        child: Container(
          color: const Color(0xFFCFCDCA),
          alignment: Alignment.center,
          child: const Icon(Icons.photo, color: Colors.white30, size: 128.0),
        ),
      ),

      // shows progress while loading an image:
      loadingBuilder: (context, progress, chunkEvent) => Center(
          child: CircularProgressIndicator(
        value: progress,
        color: Colors.red,
      )),

      // displayed when an error occurs:
      errorBuilder: (context, error) => Container(
        color: const Color(0xFF6F6D6A),
        alignment: Alignment.center,
        child: const Icon(Icons.warning, color: Colors.black26, size: 128.0),
      ),
    );
  }

  static overlayLoaderShow(BuildContext context) {
    Loader.show(context,
        overlayColor: Colors.black26,
        progressIndicator: const CircularProgressIndicator(color: ColorConst.appColor),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary:  ColorConst.appColor)));
  }

  static overlayLoaderHide(BuildContext context) {
    Loader.hide();
  }

  // static void showImagePicker(
  //     BuildContext context, ImagePickProvider imagePickProvider) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             SizedBox(height: 16.0),
  //             _buildButton(context, 'Capture with Camera', Icons.camera_alt,
  //                 () {
  //               imagePickProvider.pickImageFromCamera();
  //               Navigator.pop(context);
  //             }),
  //             SizedBox(height: 16.0),
  //             _buildButton(context, 'Pick from Gallery', Icons.photo_library,
  //                 () {
  //               imagePickProvider.pickImage();
  //               Navigator.pop(context);
  //             }),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
   static Widget _buildButton(BuildContext context, String text, IconData icon,
      VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
            ),
            const SizedBox(width: 8.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}