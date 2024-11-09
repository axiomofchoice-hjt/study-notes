# json

```python
import json
json.dumps(dict | list, indent=2) # 编码
json.loads(str) # 解码
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
