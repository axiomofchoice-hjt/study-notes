# java

- [1. 语法](#1-语法)
- [2. Spring Boot 介绍](#2-spring-boot-介绍)
- [3. pom.xml](#3-pomxml)
- [4. 主程序类 主入口类](#4-主程序类-主入口类)
- [5. 文件结构](#5-文件结构)
- [6. 配置文件](#6-配置文件)
- [7. Web 开发](#7-web-开发)
- [8. Spring 路线](#8-spring-路线)
  - [8.1. Tomcat](#81-tomcat)
  - [8.2. Maven](#82-maven)

## 1. 语法

```java
import java.util.*;
import java.math.BigInteger;
import java.math.BigDecimal;
public class Main {
    static Scanner sc = new Scanner(System.in);
    public static void main(String[] args) {
    }
}
```

```java
import java.util.*;
import java.io.*;
import java.math.BigInteger;
import java.math.BigDecimal;
public class Main {
    static Scanner cin = new Scanner(System.in);
    static PrintStream cout = System.out;
    public static void main(String[] args) {
    }
}
```

- 编译运行 `java Main.java`
- 编译 `javac Main.java` // 生成 Main.class
- 运行 `java Main`

数据类型

```java
int // 4字节有符号
long // 8字节有符号
double, boolean, char, String
```

```java
final double PI = 3.14; // final 类似 c++ 的 const
var n = 1; // var 类似 c++ 的 auto
long 型常量结尾加 L，如 1L
```

数组

```java
int[] arr = new int[100]; // 数组（可以是变量）
int[][] arr = new int[10][10]; // 二维数组
arr.length; // 数组长度，没有括号
Arrays.binarySearch(arr, l, r, x) // 在 arr[[l,r-1]] 中二分查找 x，若存在返回位置，不存在返回 -lowerbound-1
Arrays.sort(arr, l, r); Arrays.sort(arr); // 对 arr[[l, r-1]] 排序
Arrays.fill(arr, l, r, x); Arrays.fill(arr, x); // 填充 arr[[l, r-1]] 为x
```

极其麻烦的结构体 compareTo 重载

```java
public class Main {
public static class node implements Comparable<node> {
    int x;
    public node() {}
    public int compareTo(node b) {
        return x - b.x;
    }
}
static Scanner sc;
public static void main(String[] args) {
    sc = new Scanner(System.in);
    int n = sc.nextInt();
    node[] a = new node[n];
    for (int i = 0; i < n; i++) {
        a[i] = new node();
        a[i].x = sc.nextInt();
    }
    Arrays.sort(a);
    for (node i : a)
        System.out.print(i.x + " ");
    System.out.println();
}
}
```

输出

```java
System.out.print(x);
System.out.println();
System.out.println(x);
System.out.printf("%.2f\n", d); // 格式化
```

输入

```java
import java.util.Scanner;
Scanner sc = new Scanner(System.in); // 初始化
String s = sc.nextLine(); // 读一行字符串
int n = sc.nextInt(); // 读整数
double d = sc.nextDouble(); // 读实数
sc.hasNext() // 是否读完
```

String

```java
s1.equals(s2) // 返回是否相等
s1.compareTo(s2) // s1 > s2 返回 1，s1 < s2 返回 -1，s1 == s2 返回 0
s1.contains(s2) // 返回是否包含子串 s2
s1.indexOf(s2, begin = 0) // 查找子串位置
s1.substring(l, r) // 返回子串 [l,r-1]
s1.charAt(x) // 类似 c++ 的 s1[x]
s1.length() // 返回长度
s1 + s2 // 返回连接结果
String.format("%d", n) // 返回格式化结果
```

StringBuffer / StringBuilder

```java
StringBuffer s1 = new StringBuffer();
StringBuffer s1 = new StringBuffer("A");
s1.append("A"); // 类似 c++ 的 s1 += "A";
s1.reverse(); // 反转字符串
s1.replace(l, r, "A"); // 将子串 [l, r - 1] 替换为 "A" (delete + insert)
s1.charAt(x); // 类似 c++ 的 s1[x]
s1.setCharAt(x, c); // 类似 c++ 的 s1[x] = c;
```

Math

```java
// 不用 import 就能用下列函数
Math.{sqrt, sin, atan, abs, max, min, pow, exp, log, PI, E}
```

Random

```java
import java.util.Random;
Random rnd = new Random(); // 已经把时间戳作为了种子
rnd.nextInt();
rnd.nextInt(n); // [0, n)
```

BigInteger

```java
import java.math.BigInteger;
BigInteger n;
new BigInteger("0"); // String 转换为 BigInteger
BigInteger.valueOf(I) // int / long 转换为 BigInteger
BigInteger.ZERO / ONE / TEN // 0 / 1 / 10
sc.nextBigInteger() // 读入，括号里可以写进制
BigInteger[] arr = new BigInteger[10];
n1.intValue / longValue() // 转换为 int / long（太大直接丢失高位，不报异常，报异常可以后面加 Exact）
n1.add / subtract / multiply(n2) // 加 减 乘
n1.divide / mod(n2) // 整除 取模
n1.compareTo(n2) // n1 > n2 返回 1，n1 < n2 返回 -1，n1 == n2 返回 0
n1.equals(n2) // 判断相等
n1.abs() n1.pow(I) n1.gcd(n2) n1.max / min(n2) // int I
n1.modPow(n2,n3) n1.modInverse(n2) // 快速幂 逆元(gcd(n1,n2)!=1)
n1.toString(I) // 返回 I 进制字符串
n1.and / or / xor / shiftLeft / shiftRight(n2) // 位运算
n1.testBit(I) n1.setBit / clearBit / flipBit(I) // 取二进制第 I 位，操作第 I 位
n1.bitCount() // 二进制 1 的个数
// 运算时 n2 一定要转换成 BigInteger
```

BigDecimal

```java
import java.math.BigDecimal;
n1.divide(n2, 2, BigDecimal.ROUND_HALF_UP) // 保留 2 位（四舍五入）
```

## 2. Spring Boot 介绍

Spring Boot：简化 Spring 应用开发，J2EE 一站式解决方案。

微服务：拆分为一组小型服务，用 HTTP 互通。

开始：start.spring.io 里选择依赖 spring web，改一下名字，然后生成项目。

启动：`mvn spring-boot:run`（或点按钮）

部署：spring-boot-maven-plugin 插件可以部署（那个网站已经搞好了），`mvn package` 导出 jar 到 target 文件夹，然后 `java -jar file.jar` 可以运行。

## 3. pom.xml

父项目写在 `<parent>` 标签里（spring-boot-starter-parent），也是个 `pom.xml` 文件。

父项目的父项目（spring-boot-dependencies）定义了 Spring Boot 应用的所有依赖。

依赖写在 `<dependency>` 标签里：

- spring-boot-starter-web：Spring Boot 场景启动器，导入 web 的依赖。
- Spring Boot 将各个场景抽取出来做成 starters。

## 4. 主程序类 主入口类

```java
@SpringBootApplication
public class HelloWorldMainApplication {
    public static void main(String[] args) {
        SpringApplication.run(HelloWorldMainApplication.class, args);
    }
}
```

`@SpringBootApplication` 标志了主配置类，运行这个类的 main 来启动配置。主配置类所在包和所有子包的所有组件将扫描到 Spring 容器。

`@RestController` = `@ResponseBody` + `@Controller`

- `@ResponseBody` 将方法的返回值写入 response 的 body 中。写在类前表示所有方法都有效。
- `@Controller` 控制层。

## 5. 文件结构

- root/src/main
  - java
  - resources
    - static：放静态资源 (js css img)
    - templates：放模板页面（默认不支持 JSP）
    - application.properties：Spring Boot 应用的配置文件，可以写 `server.port=8080`

## 6. 配置文件

application.properties/application.yml，后者是 yaml 语法。

root/src/main/resources/application.properties

`@ConfigurationProperties(prefix = "xx")` 将配置注入到一个类，不区分连接符、下划线、大小写。

`@Value("${xxx}")` 将配置注入到一个变量，支持 SpEL，只支持基本类型。

## 7. Web 开发

类前加 `@RestController`，将返回值处理为 json。

## 8. Spring 路线

### 8.1. Tomcat

配置 JAVA_PATH，下载解压后双击 bin 里的 startup.bat 启动（端口 8080）

`tomcat/conf/server.xml` 中：（可以改域名、端口、应用路径 appBase）

```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
<!-- ... -->
<Host name="localhost"  appBase="webapps"
      unpackWARs="true" autoDeploy="true">
```

webapps 文件夹目录结构：

- webapps
  - ROOT（用 `/` 访问）
    - ...
  - webAppName（用 `/webAppName` 访问）
    - index.jsp / html / ...（默认的首页）
    - WEB-INF
      - web.xml（配置）
      - classes（文件夹，java 程序）
      - lib（依赖的 jar 包）
    - static
      - js / css / img

### 8.2. Maven

下载解压，配置 MAVEN_PATH。

在 `D:\Apps\apache-maven-3.8.4\conf\settings.xml` 中：

```xml
<localRepository>D:/Apps/apache-maven-3.8.4/repo</localRepository>
<!-- in mirrors -->
<mirror>
    <id>nexus-aliyun</id>
    <mirrorOf>central</mirrorOf>
    <name>Nexus aliyun</name>
    <url>http://maven.aliyun.com/nexus/content/groups/public</url>
</mirror>
```

然后在 idea 中构建项目，选择 maven webapp，maven 选自己的，用户配置选 maven 目录中的那个。

Tomcat 配置：比较麻烦，略。
