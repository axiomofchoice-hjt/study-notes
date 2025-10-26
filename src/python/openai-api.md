# openai-api

实例代码：

```py
from openai import OpenAI
from openai.types.chat import ChatCompletionMessageParam
from typing import List


class Chat:
    def __init__(self, api_key: str):
        self.client = OpenAI(api_key=api_key, base_url="https://api.deepseek.com")
        self.messages: List[ChatCompletionMessageParam] = []

    def call(self, message: str) -> str:
        self.messages.append({"role": "user", "content": message})
        response = (
            self.client.chat.completions.create(
                model="deepseek-chat",
                messages=self.messages,
                stream=False,
            )
            .choices[0]
            .message
        )
        assert response.role == "assistant"
        assert response.content is not None
        self.messages.append({"role": response.role, "content": response.content})
        return response.content
```

```py
import os
from chat import Chat  # 导入上面写的 Chat


api_key = os.getenv("DEEPSEEK_API_KEY")
assert api_key is not None, "Please set the DEEPSEEK_API_KEY environment variable."
chat = Chat(api_key=api_key)
print(message := "Hello")
print(chat.call(message))
print(message := "What is the capital of France?")
print(chat.call(message))
```
