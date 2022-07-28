import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class QrCode extends StatefulWidget {
  QrCode({Key? key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
