import pandas as pd
import openai
from dotenv import load_dotenv
import json
import glob
import os

#.envファイルからAPIキーを取得
load_dotenv()
# APIキーを設定
openai.api_key = os.environ["OPENAI_API_KEY"]

# 入力ファイルのパスをリスト化
input_files = glob.glob('../../../assets/csv/hobby_date.csv')  

# 出力ファイルのパス
output_jsonl_file = '../../../assets/json/hobby_date.jsonl'

# 複数の入力ファイルをループで処理
with open(output_jsonl_file, 'w', encoding='utf-8') as jsonl_file:
    for input_file_path in input_files:
        df = pd.read_csv(input_file_path, encoding='utf-8') 

        # 各行をJSONL形式に変換してJSONLファイルに書き込み
        for index, row in df.iterrows():
            # promptが空でない場合、かつcompletionが空でない場合のみ変換
            if not pd.isna(row["prompt"]) and row["completion"].strip() != "":
                data = {
                    "messages": [
                        {"role": "system", "content":'''
                        回答はJSON配列の形式です。
                        あなたは趣味に合うおすすめの場所を必ず複数答えなさい。
                        回答は余暇時間の範囲内かつ常時利用できる場所に限ります。
                        '''
                        },
                        {"role": "user", "content": row["prompt"]},
                        {"role": "assistant", "content": row["completion"]}
                    ]
                }
                # JSONL形式に変換
                jsonl_line = json.dumps(data, ensure_ascii=False) + '\n'
                #jsonlファイルに書き込み
                jsonl_file.write(jsonl_line)

# 変換したファイルのパスを表示
print(f'CSVファイルをJSONLファイルに変換しました: {output_jsonl_file}')

#jsonlファイルをアップロード
upload_file = openai.File.create(
    file=open("../../../assets/json/hobby_date.jsonl", "rb"),
    purpose='fine-tune'
)

print('ファイルをアップロードしました')

#アップロードしたファイルのリストを取得

print(upload_file.list())

#学習済みモデルの削除
# openai.Model.delete("")