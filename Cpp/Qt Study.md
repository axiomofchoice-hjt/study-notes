# Qt Study

- [Qt Study](#qt-study)
  - [安装](#安装)
  - [开始](#开始)
  - [用 vscode](#用-vscode)
  - [打包](#打包)
  - [pro 文件](#pro-文件)
  - [qrc 文件](#qrc-文件)
  - [字符串](#字符串)
  - [窗口](#窗口)
  - [控件](#控件)
  - [容器](#容器)
  - [布局](#布局)
  - [样式](#样式)
  - [方法](#方法)
  - [信号和槽](#信号和槽)
  - [托盘](#托盘)
  - [资源文件](#资源文件)
  - [End](#end)

## 安装

[这里](https://download.qt.io/archive/qt/)

下载某版本的 exe，并在断网时打开

选择 MinGW 的两个选项和所有 Qt 开头的选项

## 开始

新建项目, Application, Qt Widgets Application

输名称

基类选择 QWidget 或 QMainWindow，不要创建界面

## 用 vscode

插件 C/C++, CMake, CMake Tools

F7 build, Ctrl+F5 run, Shift+F5 stop

添加 .cpp .h 后可能要删一下 build/

## 打包

- build 完后只要 exe 文件，移动到某空文件夹
- 打开 Qt 命令行，运行 `windeployqt xxx.exe`

## pro 文件

- TARGET 是目标文件名
- 每个 .cpp 要写进 SOURCES 里
- 每个 .h 要写进 HEADERS 里

## qrc 文件

...

## 字符串

用 `QObject::tr("xxx")` 的方式表示，返回值 QString，文件编码为 utf-8。

QString 由 QChar 组成，16bit

## 窗口

设置窗口为弹出式（点击窗口外区域 hide）`setWindowFlags(Qt::Popup | Qt::FramelessWindowHint | Qt::NoDropShadowWindowHint);`

## 控件

添加控件

- MainWindow 的 `private` 成员 `std::unique_ptr<QLabel> label;`
- MainWindow::MainWindow() 里 `label.reset(new QLabel("", this));`

控件

- QLabel 文本框
- QPushButton 按钮
- QLineEdit 单行输入
- QListWidget 列表框，非常简陋
  - QListView 可以替代

## 容器

- QWidget 最基础的容器
- QFrame 有边框的容器
- QScrollArea 可滚动的容器

## 布局

- QVBoxLayout 垂直布局
- QHBoxLayout 水平布局
- QGridLayout 网格布局
- QFormLayout 表单布局
- QStackedLayout 分组布局，可切换

## 样式

## 方法

## 信号和槽

信号函数向槽函数发送消息

`QObject::connect(&button,&QPushButton::clicked,&widget,&QWidget::close);`

注意点：第 1, 3 参数必须是指针，指向的类型必须继承 QObject，且 connect 必须写在继承 QObject 的类里（不知道为什么）

最后一个参数可以用 lambda

自定义信号和槽

```cpp
class MyWidget: public QWidget {
    Q_OBJECT
signals:
    void MySignal(Args);
public slots:
    void MySlot(Args); // need impl
};
```

- 触发的地方写 `emit MySignal(args);`

## 托盘

QSystemTrayIcon

`$QSystemTrayIcon.setContextMenu($QMenu)` 似乎只能用 Menu

关闭至托盘

```cpp
void MainWindow::closeEvent(QCloseEvent *event) {
    this->hide();
    event->ignore();
}
```

## 资源文件

右键 -> 新建 -> Qt Resource File -> 添加前缀 -> 右键 -> 添加现有文件

使用时 `":/前缀/文件名"`

## End