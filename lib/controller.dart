import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller class managing the state and logic.
class HomeController extends GetxController {

  /// Controller for the URL input field.
  final TextEditingController urlController = TextEditingController();

  /// Observable variable storing the current image URL.
  var imageUrl = ''.obs;

  /// Observable variable to track the visibility of the context menu.
  var menuVisible = false.obs;

  /// Reference to the HTML image element displayed on the page.
  html.ImageElement? imgElement;

  /// Enters fullscreen mode.
  void enterFullscreen() {
    js.context.callMethod('eval', ["document.documentElement.requestFullscreen();"]);
  }

  /// Exits fullscreen mode.
  void exitFullscreen() {
    js.context.callMethod('eval', ["document.exitFullscreen();"]);
  }

  /// Updates the image display based on the entered URL.
  void setImage() {
    imageUrl.value = urlController.text;
    if (imageUrl.value.isNotEmpty) {
      imgElement?.remove();
      imgElement = html.ImageElement(src: imageUrl.value)
        ..style.position = 'absolute'
        ..style.top = '50%'
        ..style.left = '50%'
        ..style.transform = 'translate(-50%, -50%)'
        ..style.maxWidth = '100%'
        ..style.maxHeight = '100%'
        ..onDoubleClick.listen((_) => enterFullscreen());
      html.document.body?.children.add(imgElement!);
    }
  }

  /// Toggles the visibility of the context menu.
  void toggleMenu() {
    menuVisible.value = !menuVisible.value;
  }
}