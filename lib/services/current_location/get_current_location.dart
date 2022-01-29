import 'package:app_settings/app_settings.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GetCurrentLocation {
  Position? position;
  List<Placemark>? placeMarks;
  Future<String?> getCurrentLocation() async {
    // Permission _permission = Permission.location;
    PermissionStatus _status = await Permission.location.request();

    if (_status.isPermanentlyDenied) {
      print("===================");
      // openAppSettings();
      AppSettings.openAppSettings();
    }

    if (!_status.isGranted) {
      await Permission.location.request();
    } else {
      Position newPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = newPosition;
      placeMarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );
      Placemark pMark = placeMarks![1];
      print(pMark);
      String completeAddress =
          "${pMark.subLocality} ${pMark.locality} ${pMark.subAdministrativeArea} ${pMark.administrativeArea} ";
      print(completeAddress);
      return completeAddress;
    }
  }
}
