#pip install python-dotenv
#pip install flask
#pip install requests

# pythonProjectフォルダに移動
# export FLASK_APP=google_api.py で環境変数を設定
# echo $FLASK_APPで環境変数が設定されているか確認
# flask run でサーバーを起動(例--host=0.0.0.0 --port=5000でホストとポートを指定)

from flask import Flask, jsonify, request
from dotenv import load_dotenv
from datetime import datetime
import os
import requests
import json

# Flaskのインスタンスを作成
app = Flask(__name__)

#.envファイルからAPIキーを取得
load_dotenv()
# APIキーの設定
PLACES_API_KEY = os.environ['PLACES_API_KEY']
DIRECTIONS_API_KEY = os.environ['DIRECTIONS_API_KEY']

#タイプを格納する配列
default_type = ['cafe','restaurant']


# ルートにアクセスしたときの処理
# 自分の現在地の周辺の場所を取得する関数（Nearby Search）
@app.route('/current_nearbysearch', methods=['GET'])
def nearbysearch_places():
    # Google Places API(Nearby Search)のリクエストURL
    nearbysearch_url = 'https://places.googleapis.com/v1/places:searchNearby'

    # クエリパラメータから設定された値を取得
    radius = request.args.get('radius', default=1000, type=int) # 半径（メートル）
    place_type = request.args.get('type', default_type, type=str)  # 取得する場所の種類
    # keyword = request.args.get('keyword', default ='', type=str)  # キーワード
    latitude = request.args.get('latitude', default=0.0, type=float)    # 緯度
    longitude = request.args.get('longitude', default=0.0, type=float)  # 経度

    # リクエストパラメータを設定
    params = {
        "languageCode": "ja",   # 取得する場所情報の言語
        "includedTypes": [place_type],  # 取得する場所の種類
        "excludedPrimaryTypes": ['hotel','train_station','airport','gym'],  # 除外する場所の種類
        "maxResultCount": 2,   # 取得する場所の最大数
        "locationRestriction": {    # 取得する場所の範囲
            "circle": {
                "center": {
                    "latitude": latitude,
                    "longitude": longitude
                },
                "radius": radius
            }
        },
        "rankPreference": "DISTANCE", # 取得する場所の順番(人気度：POPULARITY or 距離（昇順）：DISTANCE )
    }

    # へッダー情報
    headers = {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": PLACES_API_KEY,
        "X-Goog-FieldMask": "places.location,places.id,places.displayName.text,places.types,places.primaryType,places.rating,places.photos.name,places.name,places.websiteUri"
    }

    # リクエストを送信してレスポンスのJSONを取得
    response = requests.post(nearbysearch_url, json=params, headers=headers)

    # レスポンスが成功したかどうかを確認
    if response.status_code != 200:
        print('Places API Error:', response.status_code)
        print(response.text)
        return jsonify({'error': '取得に失敗しました'})

    # レスポンスをjsonファイルとしてassetsのjsonフォルダに保存  
    with open('../../../assets/json/nearbysearch.json', 'w' , encoding='utf-8') as f:
        json.dump(response.json(), f, ensure_ascii=False, indent=4)

    # 取得した場所情報を返す
    return jsonify(response.json())


# ルートにアクセスしたときの処理
# テキスト検索した場所を取得する関数（Text Search）
@app.route('/current_textsearch', methods=['GET'])
def textsearch_places():    
    # Google Places API(Text Search)のリクエストURL
    textsearch_url = 'https://places.googleapis.com/v1/places:searchText'

    # クエリパラメータから設定された値を取得
    textQuery = request.args.get('textQuery', default ='', type=str)  #入力されたテキスト
    radius = request.args.get('radius', default=100, type=int) # 半径（メートル）
    latitude = request.args.get('latitude', default=0.0, type=float)    # 緯度
    longitude = request.args.get('longitude', default=0.0, type=float)  # 経度

    # リクエストパラメータを設定
    params = {
        "textQuery" : textQuery,    # 入力されたテキスト
        "languageCode": "ja",
        "maxResultCount": 3,
        "locationBias": {    # 取得する場所の範囲
            "circle": {
                "center": {
                    "latitude": latitude,
                    "longitude": longitude
                },
                "radius": radius
            }
        },
        # "openNow": True,
        "rankPreference": "DISTANCE", # 取得する場所の順番(人気度：RELEVANCE or 距離（昇順）：DISTANCE )
    }

    # へッダー情報
    headers = {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": PLACES_API_KEY,
        "X-Goog-FieldMask": "places.name,places.location,places.id,places.displayName.text,places.types,places.primaryType,places.rating,places.photos.name,places.websiteUri"
    }

    # リクエストを送信してレスポンスのJSONを取得
    response = requests.post(textsearch_url, json=params, headers=headers)

    # レスポンスが成功したかどうかを確認
    if response.status_code != 200:
        print('Places API Error:', response.status_code)
        print(response.text)
        return jsonify({'error': '取得に失敗しました'})

    # レスポンスをjsonファイルとしてassetsのjsonフォルダに保存
    with open('../../../assets/json/textsearch.json', 'w' , encoding='utf-8') as f:
        json.dump(response.json(), f, ensure_ascii=False, indent=4)

    # 取得した場所情報を返す
    return jsonify(response.json())

# ルートにアクセスしたときの処理
# 検索したルートを取得する関数（Directions API）
@app.route('/current_places_root', methods=['GET'])
def places_root():   
    # Google Directions APIのリクエストURL
    root_url = 'https://maps.googleapis.com/maps/api/directions/json'

    print(root_url)

    # クエリパラメータから設定された値を取得
    origin = request.args.get('origin', default ='', type=str)  
    destination = request.args.get('destination', default ='', type=str)  
    waypoints = request.args.get('waypoints', default ='', type=str) 
    arrival_time = request.args.get('arrival_time', default ='', type= str)  
    
    if arrival_time:
        try:
            arrival_time = datetime.fromisoformat(arrival_time)
        except ValueError:
            return jsonify({'error': 'Invalid arrival_time format. Please use ISO 8601 format.'})
        
    # transit_routing_preference = request.args.get('transit_routing_preference', default ='', type=str)
        
    # if request.args.get('waypoints', default ='', type=str) == '':
    #     alternatives = request.args.get('alternatives', default = True, type=bool)
    # else:
    #     alternatives = request.args.get('alternatives', default = False, type=bool)

    #waypointsをリストに変換
    waypoints = '|'.join(waypoints.split(',') )

    print(waypoints)

    # リクエストパラメータを設定
    params = {
        "origin" : origin,  # 出発地
        "destination" : destination,  # 目的地
        "waypoints" : waypoints,   # 経由地
        "mode" : 'walking',  # 交通手段　（driving, walking, bicycling, transit）
        "language" : "ja",  # 言語
        "units" : 'metric',    # 単位
        "avoid" : ['tolls','highways','indoor'],    # 回避する場所
        "arrival_time" : arrival_time,  # 到着時間
        # "transit_routing_preference" : less_walking, # less_walking or fewer_transfers      
            # less_walking は、歩行距離に制限を付けてルートを計算するよう指定。
            # fewer_transfers は、乗り換え回数に制限を付けてルートを計算するよう指定
        # "alternatives" : alternatives,  # 代替ルート（中間地点がない場合のみ）
        # "region" : 'jp',  # 地域
        "optimize_waypoints" : True,  # 経由地の最適化
        "travel_mode" : 'WALKING',    # 交通手段
        "key" : DIRECTIONS_API_KEY   # APIキー
    }

    # リクエストを送信してレスポンスのJSONを取得
    response = requests.get(root_url, params=params)

    # レスポンスが成功したかどうかを確認
    if response.status_code != 200:
        print(' Directions API Error:', response.status_code)
        print(response.text)
        return jsonify({'error': '取得に失敗しました'})
    
    # レスポンスをjsonファイルとしてassetsのjsonフォルダに保存
    with open('../../../assets/json/root.json', 'w' , encoding='utf-8') as f:
        json.dump(response.json(), f, ensure_ascii=False, indent=4)

    # 取得した場所情報を返す
    return jsonify(response.json())
    
if __name__ == '__main__':
    app.run()