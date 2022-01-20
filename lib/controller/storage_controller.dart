import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageController extends GetxController
{
  Permission permission=Permission.manageExternalStorage;
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
    } catch (e) {
      print(e);
      await openAppSettings();
    }
  }
  requestFromSettings()async
  {
    await openAppSettings();
  }
}