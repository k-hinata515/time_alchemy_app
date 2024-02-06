import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_alchemy_app/logic/flutter/get_user_hobby.dart';

class Request_API {
  Map<String, dynamic> _placesResponse = {};  // Places API のレスポンスを格納する変数
  Map<String, dynamic> _rootResponse = {};  // Places API のレスポンスを格納する変数

  List<String> _travel_time_list = [];  // 移動時間を格納するリスト
  List<String> _user_hobby_List = [];  // ユーザーの趣味を格納する変数
  List<String> _hobby_place_name = [];  // ユーザーの趣味に関連する場所を格納する変数

  // Places API (nearbySearch)にリクエストするための関数
  Future<Map<String, dynamic>> nearbySearchRequest(String latitude , String longitude) async {
    try {
      // Places API (nearbySearch) にリクエスト
      final http.Response response = await http.get(Uri.parse(
          'http://10.200.0.210:5000/current_nearbysearch?latitude=$latitude&longitude=$longitude'));

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
          'http://10.200.0.210:5000/current_textsearch?textQuery=$text&latitude=$latitude&longitude=$longitude'));

      // 取得したデータを _placesResponse に代入
      _placesResponse = json.decode(response.body);
      
    } catch (error) {
        print(error);
    }
    return _placesResponse;
  }


    // Directions APIにリクエストするための関数
  Future<List<String>> directionsRequest(
    String latitude, 
    String longitude, 
    String next_appointment_latitude, 
    String next_appointment_longitude,
    List<String> waypoints_list,
    DateTime next_appointment_time
  ) async {
    try {
      //次の予定の到着時間をUTCに変換
      String arrival_time_UTC = await next_appointment_time.toUtc().toIso8601String();
      
      // Directions API にリクエスト
      final http.Response directionsResponse = await http.get(Uri.parse(
          'http://10.200.0.210:5000/current_places_root?origin=$latitude,$longitude&destination=$next_appointment_latitude,$next_appointment_longitude&waypoints=$waypoints_list&arrival_time=$arrival_time_UTC'));

      // 取得したデータを _rootResponse に代入
      _rootResponse = json.decode(directionsResponse.body);

      // 取得した移動時間を_travel_time_listに格納
      for (int i = 0; i < _rootResponse['routes'][0]['legs'].length; i++) {
        _travel_time_list.add(_rootResponse['routes'][0]['legs'][i]['duration']['text']);
      }      
    } catch (error) {
        print(error);
    }
    return _travel_time_list;
  }

  //OpenAI APIにリクエストするための関数
  Future<List<String>> openAIRequest() async {
    try {
      print('リクエストされた');
      // _user_hobby_List = Get_User_Hobby().getUserHobbyData() as List<String>;
      //TODO:test
      _user_hobby_List = ['ファッション'];
      // OpenAI API にリクエスト
      final http.Response openAIResponse = await http.get(Uri.parse(
          'http://IP/current_openAI?hobby=$_user_hobby_List'));
      //ResponseStrにリクエスト結果を格納
      String ResponseStr = json.decode(openAIResponse.body);
      //ResponseStrをMap型に変換
      Map<String, dynamic> ResponseMap = json.decode(ResponseStr);
      
      // 取得したデータを _hobby_List に代入
      _hobby_place_name = List<String>.from(ResponseMap['hobby_places']);

      print('受け取った');
    } catch (error) {
        print(error);
    }
    return _hobby_place_name;
  }
}