# cd lib/logic/pythonでディレクトリ移動
# app.run(host='', port=)(例--host=0.0.0.0 --port=5000でホストとポートを指定)
# python openai_api.pyでサーバーを起動 

from flask import Flask, jsonify, request
from dotenv import load_dotenv
import os
import json
import openai

# Flaskのインスタンスを作成
app = Flask(__name__)

#.envファイルからAPIキーを取得
load_dotenv()
# APIキーを設定
openai.api_key = os.environ["OPENAI_API_KEY"]

# ルートにアクセスしたときの処理
@app.route('/current_openAI', methods=['GET'])
def hobby_places():

    # クエリパラメータから設定された値を取得
    hobby = request.args.get('hobby', default='', type=str) #趣味

    # ユーザーの質問に対する回答を生成するためのプロンプト
    system_prompt = '''
    回答はJSON配列の形式です。
    あなたは趣味に合うおすすめの場所やお店を必ず複数答えなさい。
    趣味が一つにつき、最低3つの場所やお店を回答すること。
    回答は余暇時間の範囲内かつ常時利用できる所に限る。
    '''
    assistant_prompt = '[{"hobby_places":String}]'
    prompt = f'{hobby}の趣味に合う場所は?'

    # OpenAI APIにリクエストを送信
    response = openai.ChatCompletion.create(
        model="学習させたモデルのID",
        response_format={"type":"json_object"},
        messages=[
            {"role": "system", "content": system_prompt},
            { 'role': 'assistant', 'content': assistant_prompt },
            {"role": "user", "content": prompt}
        ]
    )
    # レスポンスをjsonファイルとしてassetsのjsonフォルダに保存  
    with open('../../../assets/json/openai.json', 'w' , encoding='utf-8') as f:
        json.dump(response.to_dict_recursive(), f, ensure_ascii=False, indent=4)

    # レスポンスを返す
    return jsonify(response['choices'][0]['message']['content'])

if __name__ == '__main__':
    app.run()