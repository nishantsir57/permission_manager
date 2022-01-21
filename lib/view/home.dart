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

  final cameraController = Get.put(CameraController());
  final storageController=Get.put(StorageController());
  final contactController=Get.put(ContactController());
  final locationController=Get.put(LocationController());
  final sensorController=Get.put(SensorController());
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isChanged)async{
        print('drawer changed is running');
      },
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text('Please allow for Camera permission from settings'),
                  content: Text('Permissions > Select Permission > Allow'),
                  actions: [
                    RaisedButton(
                      child: Text('Open App Settings'),
                      onPressed: ()async{
                        await cameraController.requestFromSettings();
                        await storageController.requestFromSettings();
                        await contactController.requestFromSettings();
                        await locationController.requestFromSettings();
                        await sensorController.requestFromSettings();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );});
        },
        child: Icon(Icons.settings),
      ),
    );
  }

  buildBody() {
    return Obx((){
      return ListView(
        children: [
          ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              trailing: makeContainer(cameraController.isAllowed.value),
              onTap: ()async=> await camera()
          ),
          ListTile(
              leading: Icon(Icons.sd_storage_outlined),
              title: Text('Storage'),
              trailing: makeContainer(storageController.isAllowed.value),
              onTap: ()async => await storage()
          ),
          ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contacts'),
              trailing: makeContainer(contactController.isAllowed.value),
              onTap: ()async => await contacts()
          ),
          ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location'),
              trailing: makeContainer(locationController.isAllowed.value),
              onTap: ()async => await location()
          ),
          ListTile(
              leading: Icon(Icons.sensors_rounded),
              title: Text('Sensors'),
              trailing: makeContainer(sensorController.isAllowed.value),
              onTap: ()async => await sensor()
          )
        ],
      );
    });
  }

  camera() async {

    PermissionStatus status=await cameraController.checkStatus();
    if(status.isGranted)
      {
        Get.to(Granted('camera permission'));
      }
    else if(status.isDenied)
      {
        if(cameraController.denyCount.value <= 1)
          {
            await cameraController.requestPermission();
          }

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
                        await cameraController.requestFromSettings();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );});

  }
  }

  storage()async {
    PermissionStatus status=await storageController.checkStatus();
    if(status.isGranted)
    {
      Get.to(Granted('Storage permission'));
    }
    else if(status.isDenied)
    {
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
                      await storageController.requestPermission();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
            );
        // await storageController.checkStatus();
    }
  }

  contacts()async {
    PermissionStatus status=await contactController.checkStatus();
    if(status.isGranted)
    {
      Get.to(Granted('Contact permission'));
    }
    else if(status.isDenied)
    {
      if(contactController.denyCount <= 1) {
        await contactController.requestPermission();
      }
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
                      await contactController.requestFromSettings();
                      Navigator.of(context).pop();
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
    PermissionStatus status=await locationController.checkStatus();
    if(status.isGranted)
    {
      Get.to(Granted('Location permission'));
    }
    else if(status.isDenied)
    {
      if(locationController.denyCount <= 1)
        {
          await locationController.requestPermission();
        }
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
                      await locationController.requestFromSettings();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );});

    }
  }

  sensor() async{
    PermissionStatus status=await sensorController.checkStatus();
    if(status.isGranted)
    {
      Get.to(Granted('Sensor permission'));
    }
    else if(status.isDenied)
    {
      if(sensorController.denyCount.value <= 1) {
        await sensorController.requestPermission();
      }
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
                      await sensorController.requestFromSettings();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );});

    }
  }

  makeContainer(isAllowed) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isAllowed?Colors.greenAccent:Colors.red
      ),
    );
  }

}
