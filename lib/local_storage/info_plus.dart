import 'package:package_info_plus/package_info_plus.dart';

class Info{
  static final Info _singleton = Info._internal();

  factory Info() {
    return _singleton;
  }

  Info._internal();

   PackageInfo? packageInfo;

   Future<void> init()async{
    packageInfo=await PackageInfo.fromPlatform();
  }
}

final info=Info();


