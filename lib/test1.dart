import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class Testing1 extends StatefulWidget {
  @override
  _Testing1State createState() => _Testing1State();
}

class _Testing1State extends State<Testing1> {
  GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey();
  String filePath = 'assets/maps/home.jpg';
  int x = 2000;
  int y = 2000;
  late int imgX;
  late int imgY;
  bool init = true;
  int originX = 2000;
  int originY = 2000;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ExtendedImage.asset(
        filePath,
        extendedImageEditorKey: editorKey,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        initEditorConfigHandler: (state) {
          print(state!.imageWidget.height);
          print("($x,$y)");
          return EditorConfig(
            editActionDetailsIsChanged: (d) {
              double scale = d!.totalScale;
              print(scale);
              Size s = d.cropRect!.size;
              if (init) {
                setState(() {
                  imgX = s.width.toInt();
                  imgY = s.height.toInt();
                  init = false;
                });
              } else {
                int y = (s.width * (originY / imgY) / scale).toInt();
                int x = (s.height * (originX / imgX) / scale).toInt();
                print("x = $x, y = $y");
              }
            },
          );
        },
      ),
    );
  }
}
