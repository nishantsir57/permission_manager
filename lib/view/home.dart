import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_manager/controller/camera_controller.dart';
import 'package:permission_manager/controller/contact_controller.dart';
import 'package:permission_manager/controller/location_controller.dart';
import 'package:permission_manager/controller/storage_controller.dart';

import 'granted.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}
class HomeState extends State<Home> {
  final _cameraController = Get.put(CameraController());
  final _storageController=Get.put(StorageController());
  final _contactController=Get.put(ContactController());
  final _locationController=Get.put(LocationController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  buildBody() {
    String s = 'not asked';
    return ListView(
      children: [
        ListTile(
            leading: Icon(Icons.camera),
            title: Text('Camera'),
            onTap: ()async=> await camera()
        ),

        ListTile(
            leading: Icon(Icons.sd_storage_outlined),
            title: Text('Storage'),
            onTap: ()async => await storage()
        ),
        ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contacts'),
            onTap: ()async => await contacts()
        ),
        ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Location'),
            onTap: ()async => await location()
        )
      ],
    );
  }

  camera() async {

    PermissionStatus status=await _cameraController.checkStatus();
    if(status.isGranted)
      {
        Get.to(Granted('camera permission'));
      }
    else if(status.isDenied)
      {
        if(_cameraController.denyCount <= 1)
          await _cameraController.requestPermission();
        else
          await _cameraController.requestFromSettings();
      }
  }

  storage()async {
    PermissionStatus status=await _storageController.checkStatus();
    if(status.isGranted)
    {
      Get.to(Granted('Storage permission'));
    }
    else if(status.isDenied)
    {
      // if(_storageController.denyCount <= 1)
        await _storageController.requestPermission();
      // else
      //   await _storageController.requestFromSettings();
    }
  }

  contacts()async {
    PermissionStatus status=await _contactController.checkStatus();
    if(status.isGranted)
    {
      Get.to(Granted('Contact permission'));
    }
    else if(status.isDenied)
    {
      if(_contactController.denyCount <= 1)
        await _contactController.requestPermission();
      else
        await _contactController.requestFromSettings();
    }
  }

  location()async {
    PermissionStatus status=await _locationController.checkStatus();
    if(status.isGranted)
    {
      Get.to(Granted('Location permission'));
    }
    else if(status.isDenied)
    {
      if(_locationController.denyCount <= 1)
        await _locationController.requestPermission();
      else
        await _locationController.requestFromSettings();
    }
  }

}
