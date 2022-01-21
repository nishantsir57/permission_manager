import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController
{
  Permission permission=Permission.locationWhenInUse;
  Permission permission1=Permission.locationAlways;
  RxInt denyCount=0.obs;
  RxBool isAllowed=false.obs;
  checkStatus()async
  {
    PermissionStatus status=await permission.status;
    if(status.isGranted)
      isAllowed.value=true;

    return status;
  }
  requestPermission() async
  {
    denyCount++;
    try{
      await permission.request();
      await checkStatus();
    }catch(e)
    {

      await openAppSettings();
    }
  }
  requestFromSettings()async
  {
    await openAppSettings();
    await checkStatus();
  }
}