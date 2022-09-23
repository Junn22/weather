import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation {
  double? latitude2;
  double? longitude2;

  Future<void> getMyCurrentLocation () async{
    try {
      //아래 코드를 적어야 권한 허용 표시가 뜸.
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      // print(latitude2);
      // print(longitude2);
    } catch (e) {
      print('현재 위치를 가져올 수 없습니다.');
    }
  }
}