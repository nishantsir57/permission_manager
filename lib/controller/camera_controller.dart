
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraController extends GetxController
{
  Permission permission=Permission.camera;
  checkStatus()async
  {
    return await permission.status;
  }
  requestPermission() async
  {
    await permission.request();
    // openAppSettings();
    print('asked for permission');
  }
}