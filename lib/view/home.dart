import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_manager/controller/camera_controller.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final _cameraController = Get.put(CameraController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  buildBody() {
    String s = 'not asked';
    return ListView(
      children: [
        Obx(()=>ListTile(
            leading: Icon(Icons.camera),
            title: Text('Camera'),
            trailing: Text(s),
            onTap: ()=> camera(_cameraController)
        ),),
      ],
    );
  }

  camera(CameraController controller) async {
    PermissionStatus status=controller.checkStatus();
    if(status.isDenied)
      {
        await Permission.camera.request();

        // bool output=await openAppSettings();

        Scaffold.of(context).showSnackBar(
          new SnackBar(content: Text('Permission Requested'))
        );
      }

    print(status.isDenied);
    print(status.isGranted);
    print(status.isLimited);
    print(status.isRestricted);
    print(status.isBlank);
  }
}
