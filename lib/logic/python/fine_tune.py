import openai
from dotenv import load_dotenv
import os

#.envファイルからAPIキーを取得
load_dotenv()
# APIキーを設定
openai.api_key = os.environ["OPENAI_API_KEY"]

#ファインチューニングを開始
fine_tune = openai.FineTuningJob.create(
        training_file="アップロードしたファイルのID",
        model="gpt-3.5-turbo-1106"
    )

print(fine_tune.list(limit=10))

