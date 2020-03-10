import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';


List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  static const String id = 'camera_screen';
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<CameraScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<CameraDescription> cameras;
  CameraController controller;
  bool isReady = false;
  bool showCamera = true;
  String imagePath;
  TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      if (cameras.length > 0) {
        controller = new CameraController(cameras[0], ResolutionPreset.medium);
        await controller.initialize();
      }
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: showCamera
                  ? Container(
                      height: 290,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Center(child: cameraPreviewWidget()),
                      ),
                    )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      imagePreviewWidget(),
                      editCaptureControlWidget(),
                    ],
                  ),
              ),
              showCamera ? captureControlWidget() : Container(),
              cameraOptionsWidget(),
              // captionInputWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget cameraPreviewWidget() {
    if (!isReady || controller == null || !controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  Widget imagePreviewWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Align(
          alignment: Alignment.topCenter,
          child: imagePath == null 
            ? null
            : SizedBox(
               child: Image.file(File(imagePath)),
               height: 290.0,
             ),
        ),
      ),
    );
  }

  void onTakePicturePressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          showCamera = false;
          imagePath = filePath;
        });
      }
    });
  }

  /// the current time, in “seconds since the epoch”
  static int currentTimeInSeconds() {
      var ms = (new DateTime.now()).millisecondsSinceEpoch;
      return (ms / 1000).round();
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/rw_symposium';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${currentTimeInSeconds().toString()}.jpg';
    if (controller.value.isTakingPicture) {
      return null;
    }
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (err) {
      return null;
    }
    return filePath;
  }

  Widget captureControlWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.camera_alt),
          color: Colors.white,
          onPressed: controller != null && controller.value.isInitialized
            ? onTakePicturePressed
            : null,
        ),
      ],
    );
  }

  Widget editCaptureControlWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Align(
        alignment: Alignment.topCenter,
        child: IconButton(
          icon: Icon(Icons.camera_alt),
          color: Colors.white,
          onPressed: () => setState(() {
            showCamera = true;
          }),
        ),
      ),
    );
  }

  Widget cameraOptionsWidget() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          showCamera ? cameraTogglesRowWidget() : Container(),
        ],
      ),
    );
  }

  IconData getCameraLensIcon(dir) {
    return Icons.camera_front;
  }


  Widget cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (cameras != null) {
      if (cameras.isEmpty) {
        return const Text('No camera found');
      } else {
        for (CameraDescription cameraDescription in cameras) {
          toggles.add(
            SizedBox(
              width: 90.0,
              child: RadioListTile<CameraDescription>(
                title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
                groupValue: controller?.description,
                value: cameraDescription,
                onChanged: controller != null ? onNewCameraSelected : null,
              ),
            ),
          );
        }
      }
    }

    return Row(children: toggles);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        // showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      // showInSnackBar('Camera error ${e}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget captionInputWidget() {
    return null;
  }

}