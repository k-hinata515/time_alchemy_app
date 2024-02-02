class Time_Conversion {
  Future<List<Map<String, String?>>> convertTime(
    DateTime time_now ,   // 現在時刻
    List<String> travel_time , // 移動時間
    DateTime next_appointment_time  // 次の予定の時間
  ) async {

    print(next_appointment_time);
    print(time_now);

    final List<Map<String, String?>> time_List = []; // 出発、到着、平均滞在時刻を格納するリスト
    final List<String> departure_time = []; // 出発時刻を格納するリスト
    final List<String> arrival_time = []; // 到着時刻を格納するリスト

    String average_stay_time; // 平均滞在時間を格納する変数
        
    // 現在時刻をint型に変換し分換算にする
    int time_now_int = time_now.hour * 60 + time_now.minute;
    print('現在時刻（分換算）$time_now_int');
    

    //next_appointment_timeをint型に変換し分換算にする（次の予定の時間）
    int next_appointment_time_int = next_appointment_time.hour * 60 + next_appointment_time.minute -10;
    print('次の予定の時間（分換算）$next_appointment_time_int');

    // travel_time（"〜時間〜分"）の値を00:00の形式に変換
    for (int i = 0; i < travel_time.length; i++) {

      travel_time[i] = travel_time[i].replaceAll("時間", ":");
      travel_time[i] = travel_time[i].replaceAll("分", "");

      if (travel_time[i].length == 4) {
        travel_time[i] = "0" + travel_time[i];
      }

      if (travel_time[i].length == 1) {
        travel_time[i] = "00:0" + travel_time[i];
      }

      if (travel_time[i].length == 2) {
        travel_time[i] = "00:" + travel_time[i];
      }
    }

    print(travel_time);
    

    final List<int> travel_time_List = [];  //変換したtravel_timeを格納するリスト(移動時間)

    // String型のtravel_timeをint型に変換し分換算にする
    for (int i = 0; i < travel_time.length; i++) {
      int hour = int.parse(travel_time[i].substring(0, 2));
      int minute = int.parse(travel_time[i].substring(3, 5));
      travel_time_List.add(hour * 60 + minute);
    }
    print('移動時間(分換算)$travel_time_List');


    int sum_travel_time = 0;  //移動時間の合計を格納する変数

    //移動時間の合計を計算
    for (int i = 0; i < travel_time_List.length; i++) {
      sum_travel_time += travel_time_List[i];
    }
    print('移動時間合計(分換算）$sum_travel_time');


    //next_appointment_time_intからsum_travel_timeの差分を計算(平均滞在時間)
    double average_stay_time_double = (next_appointment_time_int - (time_now_int + sum_travel_time)) / (travel_time_List.length - 1).truncate();
    //average_stay_time_doubleが負の値の場合は1日の最大値を足す
    if(average_stay_time_double < 0){
      average_stay_time_double = 1440 + average_stay_time_double;
    }
    print('平均滞在時間(分換算）$average_stay_time_double');


    //現在時刻から最初の経由場所の到着時刻を計算(到着時刻)
    int arrival = time_now_int + travel_time_List[0].toInt() ;
    arrival_time.add(formatTime(arrival));

    for (int i = 1; i <= travel_time_List.length - 1; i++) {
      //到着時刻から平均滞在時間の合計を計算(出発時刻)
      int departure = arrival + average_stay_time_double.toInt() ;
      departure_time.add(formatTime(departure)); 

      //出発時刻から移動時間を計算(到着時刻)
      arrival = departure + travel_time_List[i];
      arrival_time.add(formatTime(arrival));

      //経由地点間の時刻を追加
      time_List.add({
        'arrival_time': arrival_time[i - 1],
        'departure_time': departure_time[i - 1],
        'average_stay_time': "${average_stay_time_double.toStringAsFixed(0)}分",
      });
    }

    time_List.add({
      'arrival_time': arrival_time[arrival_time.length-1],
      'departure_time': null,
      'average_stay_time': "${average_stay_time_double.toStringAsFixed(0)}分",
    });

    //average_stay_time_doubleを○時間○分形式に変換
    // int hour = (average_stay_time_double / 60).truncate();
    // int minute = (average_stay_time_double % 60).truncate();
    // average_stay_time = (hour == 0 ? "" : hour.toString().padLeft(2, '0') + "時間") + minute.toString().padLeft(2, '0') + "分";

    
    print('到着$arrival_time');
    print('出発$departure_time');
    // print('平均滞在時間$average_stay_time');
    
    print(time_List);
    return time_List;
  }
  // int型の分換算値を00:00形式に変換
  String formatTime(int time) {
    int hour = (time / 60 % 24).truncate();
    int minute = (time % 60).truncate();
    return hour.toString().padLeft(2, '0') + ":" + minute.toString().padLeft(2, '0');
  }
}