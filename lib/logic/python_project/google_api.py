# pythonProjectフォルダに移動
# export FLASK_APP=google_api.py で環境変数を設定
# echo $FLASK_APPで環境変数が設定されているか確認
# flask run でサーバーを起動(例--host=0.0.0.0 --port=5000でホストとポートを指定)

from flask import Flask, jsonify, request
from dotenv import load_dotenv
import os
import requests
import json

# Flaskのインスタンスを作成
app = Flask(__name__)

#.envファイルからAPIキーを取得
load_dotenv()
# APIキーの設定
API_KEY = os.environ['GOOGLE_API_KEY']

#タイプを格納する配列
default_type = ['cafe','restaurant']


# ルートにアクセスしたときの処理
# 自分の現在地の周辺の場所を取得する関数（Nearby Search）
@app.route('/current_nearbysearch', methods=['GET'])
def nearbysearch_places():
    # Google Places API(Nearby Search)のリクエストURL
    nearbysearch_url = 'https://places.googleapis.com/v1/places:searchNearby'

    # クエリパラメータから設定された値を取得
    radius = request.args.get('radius', default=500, type=int) # 半径（メートル）
    place_type = request.args.get('type', default_type, type=str)  # 取得する場所の種類
    # keyword = request.args.get('keyword', default ='', type=str)  # キーワード
    latitude = request.args.get('latitude', default=0.0, type=float)    # 緯度
    longitude = request.args.get('longitude', default=0.0, type=float)  # 経度

    # リクエストパラメータを設定
    params = {
        "languageCode": "ja",   # 取得する場所情報の言語
        "includedTypes": [place_type],  # 取得する場所の種類
        "excludedPrimaryTypes": ['hotel','train_station','airport','gym'],  # 除外する場所の種類
        "maxResultCount": 4,   # 取得する場所の最大数
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
        "X-Goog-Api-Key": API_KEY,
        "X-Goog-FieldMask": "places.location,places.id,places.displayName.text,places.types,places.primaryType,places.rating,places.photos.name,places.priceLevel,places.websiteUri"
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
        "maxResultCount": 2,
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
        "X-Goog-Api-Key": API_KEY,
        "X-Goog-FieldMask": "places.location,places.id,places.displayName.text,places.types,places.primaryType,places.rating,places.photos.name"
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
    
if __name__ == '__main__':
    app.run()