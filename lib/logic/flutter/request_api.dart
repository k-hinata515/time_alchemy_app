import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_alchemy_app/logic/flutter/get_user_hobby.dart';
import 'package:time_alchemy_app/logic/flutter/map_class.dart';
import 'package:time_alchemy_app/logic/flutter/time_conversion.dart';

class Request_API {
  Map<String, dynamic> _placesResponse = {};  // Places API のレスポンスを格納する変数
  Map<String, dynamic> _rootResponse = {};  // Places API のレスポンスを格納する変数

  List<String> _travel_time_list = [];  // 移動時間を格納するリスト
  List<Map<String, String?>> time_list = [];  // 出発、到着、平均滞在時刻を格納するリスト
  List<Map<String, String?>> Navigation_List = [];  // 経由地の名、到着、出発時刻を格納するリスト
  List<String> _user_hobby_List = [];  // ユーザーの趣味を格納する変数
  List<String> _hobby_place_name = [];  // ユーザーの趣味に関連する場所を格納する変数
  
  // Places API (nearbySearch)にリクエストするための関数
  Future<Map<String, dynamic>> nearbySearchRequest(String latitude , String longitude) async {
    try {
      // Places API (nearbySearch) にリクエスト
      final http.Response response = await http.get(Uri.parse(
          'http://IP:Port/current_nearbysearch?latitude=$latitude&longitude=$longitude'));

      // 取得したデータを _placesResponse に代入
      _placesResponse = json.decode(response.body);

    } catch (error) {
        print(error);
    }
    return _placesResponse;
  }


  //places API(textSearch)にリクエストする関数
  Future<Map<String, dynamic>> textSearchRequest(String text , String latitude , String longitude) async {
    try {
      // Places API (textSearch) にリクエスト
      final http.Response response = await http.get(Uri.parse(
          'http://IP:Port/current_textsearch?textQuery=$text&latitude=$latitude&longitude=$longitude'));

      // 取得したデータを _placesResponse に代入
      _placesResponse = json.decode(response.body);
      
    } catch (error) {
        print(error);
    }
    return _placesResponse;
  }


    // Directions APIにリクエストするための関数
  Future<List<Map<String, String?>>> directionsRequest(
    String latitude, 
    String longitude, 
    MapData next_appointment_data, 
    List<String> waypoints_list,
    DateTime next_appointment_time
  ) async {
    try {
      //次の予定の到着時間をUTCに変換
      String arrival_time_UTC = await next_appointment_time.toUtc().toIso8601String();
      
      // Directions API にリクエスト
      final http.Response directionsResponse = await http.get(Uri.parse(
          'http://IP:Port/current_places_root?origin=$latitude,$longitude&destination=${next_appointment_data.latitude},${next_appointment_data.longitude}&waypoints=$waypoints_list&arrival_time=$arrival_time_UTC'));

      // 取得したデータを _rootResponse に代入
      _rootResponse = json.decode(directionsResponse.body);

      // 取得した移動時間を_travel_time_listに格納
      for (int i = 0; i < _rootResponse['routes'][0]['legs'].length; i++) {
        _travel_time_list.add(_rootResponse['routes'][0]['legs'][i]['duration']['text']);
      }

      // //TODO:travel_time_Listが取得できるまで待機 (test)
      while (_travel_time_list.isEmpty) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      //出発、到着、平均滞在時刻を取得
      time_list = await Time_Conversion().convertTime(
          DateTime.now(), _travel_time_list, next_appointment_time);

      // Navigation_Listに場所名、到着、出発時刻、滞在時間を格納
      for (int i = 0; i <= time_list.length - 1; i++) {
        if (i == time_list.length - 1) {
          Navigation_List.add({
            'name': next_appointment_data.placeName,
            'arrival_time': time_list[i]['arrival_time'],
            'departure_time': time_list[i]['departure_time'],
            'average_stay_time': time_list[i]['average_stay_time'],
          });
        } else {
          Navigation_List.add({
            'name': waypoints_list[i],
            'arrival_time': time_list[i]['arrival_time'],
            'departure_time': time_list[i]['departure_time'],
            'average_stay_time': time_list[i]['average_stay_time'],
          });
        }
      }
    } catch (error) {
        print(error);
    }
    return Navigation_List;      
  }

  //OpenAI APIにリクエストするための関数
  Future<List<String>> openAIRequest() async {
    try {
      // _user_hobby_List = Get_User_Hobby().getUserHobbyData() as List<String>;
      //TODO:test
      _user_hobby_List = ['ファッション'];
      // OpenAI API にリクエスト
      final http.Response openAIResponse = await http.get(Uri.parse(
          'http://IP:Port/current_openAI?hobby=$_user_hobby_List'));
      //ResponseStrにリクエスト結果を格納
      String ResponseStr = json.decode(openAIResponse.body);
      //ResponseStrをMap型に変換
      Map<String, dynamic> ResponseMap = json.decode(ResponseStr);
      
      // 取得したデータを _hobby_List に代入
      _hobby_place_name = List<String>.from(ResponseMap['hobby_places']);

    } catch (error) {
        print(error);
    }
    return _hobby_place_name;
  }
}