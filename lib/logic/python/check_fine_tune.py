import openai
from dotenv import load_dotenv
import os

#.envファイルからAPIキーを取得
load_dotenv()
# APIキーを設定
openai.api_key = os.environ["OPENAI_API_KEY"]

#アップロードしたファイルのリストを取得
# print(openai.File.list(limit=10))

#学習状況の取得
print(openai.FineTuningJob.list(limit=10))