import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController
{
  Permission permission=Permission.locationWhenInUse;
  Permission permission1=Permission.locationAlways;
  RxInt denyCount=0.obs;
  checkStatus()async
  {
    return await permission.status;
  }
  requestPermission() async
  {
    denyCount++;
    try {
      await permission.request();
      await permission1.request();
    } catch (e) {
      await openAppSettings();
    }
  }
  requestFromSettings()async
  {
    await openAppSettings();
  }
}