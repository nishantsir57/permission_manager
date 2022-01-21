import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_manager/controller/camera_controller.dart';
import 'package:permission_manager/controller/contact_controller.dart';
import 'package:permission_manager/controller/location_controller.dart';
import 'package:permission_manager/controller/sensor_controller.dart';
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
  final _sensorController=Get.put(SensorController());

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
        ),
        ListTile(
            leading: Icon(Icons.sensors_rounded),
            title: Text('Sensors'),
            onTap: ()async => await sensor()
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
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text('Please allow for Camera permission from settings'),
                  content: Text('Permissions > Camera > Allow'),
                  actions: [
                    RaisedButton(
                      child: Text('Open App Settings'),
                      onPressed: ()async{
                        await _cameraController.requestFromSettings();
                      },
                    ),
                  ],
                );});
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
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Please allow for Storage permission from settings'),
                content: Text('Turn on "Allow access to manage all files"'),
                actions: [
                  RaisedButton(
                    child: Text('Open App Settings'),
                    onPressed: ()async{
                      await _storageController.requestPermission();
                    },
                  ),
                ],
              );});
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
        {
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Please allow for contacts permission from settings'),
                content: Text('Permissions > Contacts > Allow'),
                actions: [
                  RaisedButton(
                    child: Text('Open App Settings'),
                    onPressed: ()async{
                      await _contactController.requestFromSettings();
                    },
                  ),
                ],
              );
            }
          );

        }

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
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Please allow for Location permission from settings'),
                content: Text('Permissions > Location > Allow'),
                actions: [
                  RaisedButton(
                    child: Text('Open App Settings'),
                    onPressed: ()async{
                      await _locationController.requestFromSettings();
                    },
                  ),
                ],
              );});
    }
  }

  sensor() async{
    PermissionStatus status=await _sensorController.checkStatus();
    if(status.isGranted)
    {
      Get.to(Granted('Sensor permission'));
    }
    else if(status.isDenied)
    {
      if(_sensorController.denyCount.value <= 1)
        await _sensorController.requestPermission();
      else
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Please allow for Body Sensor permission from settings'),
                content: Text('Permissions > Body Sensors > Allow'),
                actions: [
                  RaisedButton(
                    child: Text('Open App Settings'),
                    onPressed: ()async{
                      await _sensorController.requestFromSettings();
                    },
                  ),
                ],
              );});
    }
  }

}
