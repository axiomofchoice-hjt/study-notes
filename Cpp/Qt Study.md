# Qt Study

- [Qt Study](#qt-study)
  - [安装](#安装)
  - [开始](#开始)
  - [构建](#构建)
  - [pro 文件](#pro-文件)
  - [qrc 文件](#qrc-文件)
  - [End](#end)

## 安装

[这里](https://download.qt.io/archive/qt/)

下载某版本的 exe，并在断网时打开

选择 MinGW 的两个选项和所有 Qt 开头的选项

## 开始

新建项目, Application, Qt Widgets Application

输名称

基类选择 QWidget，不要创建界面

## 构建

build 完后只要 exe 文件，然后将 qt/Qt/Qt5.9.8/5.9.8/mingw53_32/bin 下的所有 ddl 文件复制过来放一起即可运行

## pro 文件

- TARGET 是目标文件名
- 每个 .cpp 要写进 SOURCES 里
- 每个 .h 要写进 HEADERS 里

## qrc 文件

...

## End