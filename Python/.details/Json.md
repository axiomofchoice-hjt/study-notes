# Json

```python
import json
json.dumps(dict | list, indent=2) 将 Python 对象编码成 JSON 字符串
json.loads(str) 将已编码的 JSON 字符串解码为 Python 对象
```

重写 json 类实现 datetime 的输出

```py
class DateEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime.datetime):
            return obj.strftime('%Y-%m-%d %H:%M:%S')
        else:
            return json.JSONEncoder.default(self, obj)

json.dumps(xxx, cls=DateEncoder)
```
