import 'package:geolocator/geolocator.dart';

class Geolocation {
  /// デバイスの現在位置を決定する。
  /// 位置情報サービスが有効でない場合、または許可されていない場合、エラーを返す
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 位置情報サービスが有効かどうかをテストします。
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 位置情報サービスが有効でない場合、続行できません。
      // 位置情報にアクセスし、ユーザーに対して位置情報サービスを有効にするようアプリに要請する。
      return Future.error('位置情報の許可が拒否されました。');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // ユーザーに位置情報を許可してもらうよう促す
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 拒否された場合エラーを返す
        return Future.error('位置情報の許可が拒否されました。');
      }
    }
    
    // 永久に拒否されている場合のエラーを返す
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        '位置情報の許可は永久に拒否され、許可をリクエストすることはできません。');
    } 

    // ここまでたどり着くと、位置情報に対しての権限が許可されているということ
    // デバイスの位置情報を返す。
    return await Geolocator.getCurrentPosition();
  }
}