# pyyaml

```sh
pip install pyyaml
```

```python
import yaml
yaml.dump(dict | list).encode('utf-8').decode('unicode_escape')  # 编码
yaml.load(str, Loader=yaml.SafeLoader)  # 解码
```
