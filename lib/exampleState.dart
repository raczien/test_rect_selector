import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  ExampleWidgetState createState() => ExampleWidgetState();
}

class ExampleWidgetState extends State<ExampleWidget> {
  PhotoViewController photoViewController = PhotoViewController();

  var val = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            child: PhotoView(
              controller: photoViewController,
              imageProvider: const AssetImage("assets/maps/home.jpg"),
              minScale: PhotoViewComputedScale.contained * 0.5,
              maxScale: PhotoViewComputedScale.covered * 3,
            ),
          ),
        ),
        _buildScaleInfo(),
        _buildResetButton(),
        Slider(
          min: 0.1,
          max: 3.0,
          value: val,
          onChanged: (newVal) {
            setState(() {
              val = newVal;
              photoViewController.scale = val;
            });
          },
        ),
      ],
    );
  }

  StreamBuilder<PhotoViewControllerValue> _buildScaleInfo() {
    return StreamBuilder(
      stream: photoViewController.outputStateStream,
      builder: (BuildContext context,
          AsyncSnapshot<PhotoViewControllerValue> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        print(snapshot.data);
        return Center(
          child: Text('Scale compared to original: \n${snapshot.data?.scale}'),
        );
      },
    );
  }

  FloatingActionButton _buildResetButton() {
    return FloatingActionButton(
        child: const Text('Reset'),
        onPressed: () {
          photoViewController.scale = photoViewController.initial.scale;
        });
  }
}
