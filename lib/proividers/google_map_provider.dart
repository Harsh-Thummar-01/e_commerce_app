//
//
// import 'package:flutter/cupertino.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// class LocationController with ChangeNotifier{
//   Position? currentPosition;
//   bool isLoading = false;
//
//   String? currentLocation;
//
//   Future<Position> getPosition () async {
//     LocationPermission? permission;
//
//     permission = await Geolocator.checkPermission();
//     if(permission == LocationPermission.denied){
//       permission = await Geolocator.requestPermission();
//       if(permission == LocationPermission.denied){
//         return Future.error("Location permission are denied");
//       }
//     }
//     notifyListeners();
//     return await Geolocator.getCurrentPosition();
//
//   }
//
//   Future<void> getAddressFromLatLng(long,lat) async{
//     try{
//       List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
//
//       Placemark place = placeMarks[0];
//
//       currentLocation = "${place.locality},${place.street},${place.subLocality},${place.subAdministrativeArea}";
//
//     }
//     catch(e){
//       print(e);
//     }
//     notifyListeners();
//   }
//
//   Future<void> getCurrentLocation() async {
//     try {
//       isLoading = true;
//       currentPosition = await getPosition();
//
//       getAddressFromLatLng(currentPosition!.longitude, currentPosition!.latitude);
//       isLoading = false;
//     }catch(e){
//       print(e);
//     }
//   }
// }