# flask

```py
import flask

app = flask.Flask(__name__)

@app.route("/")
def index():
    return "Hello World!"

if __name__ == "__main__":
    app.run(debug = True)
```

带参数路由

```py
@app.route("/user/<name>")
def user(name):
    return name
```

- `<name>` 可以加类型限制 `<int:name>`
- 默认 string，不包含斜杠的文本
- int 正整数 float 正浮点数 path 包含斜杠的文本 uuid ？

资源

- `url_for("xxx")` 得到资源路径
- `url_for("static", filename="style.css")` 在 static 中找资源

HTTP 方法

```py
@app.route("/", methods=["GET", "POST"])
def index():
    if flask.request.method == "POST":
        return "post"
    else:
        return "get"
```

重定向

```py
@app.route("/baidu")
def baidu():
    return flask.redirect("http://www.baidu.com")
```

请求对象

- `flask.request.method` 得到请求类型（GET / POST）
- `flask.request.headers.get("User-Agent"))` 请求头中的信息
- `flask.request.args["key"]` 得到请求参数
- `flask.request.form["data"]` 得到表单数据

json

...
