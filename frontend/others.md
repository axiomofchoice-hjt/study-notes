# others

- [1. TypeScript](#1-typescript)
  - [1.1. 类型声明](#11-类型声明)
  - [1.2. 类](#12-类)
- [2. node-webkit](#2-node-webkit)

## 1. TypeScript

### 1.1. 类型声明

- any：任意类型
- number：数字（好像就一浮点型）
- string：字符串
- boolean：布尔
- `number[]`：数组
- `[number, number, ...]`：元组
- enum：枚举
- void：函数无返回值
- null：缺失
- undefined：未定义
- never：从不出现的值
- `number | number | ...`：多种值的 Union
- `{ a: number, b: number, ... }`：对象
- 函数类型好像是 `(x: number, y: number, ...) => number`

变量声明 `var x: string = "abc";`，若无初始值，其值为 `undefined`。若不声明类型，将会自动推断。

类型断言：`<number> value`

类型判断：`value instanceof type`

函数声明 `function f(x: number): number { ... }`

可选参数 `function f(x: number, y?: number)`，其中 y 是可选参数。

类型别名 `type name = number`

可以声明多个同名不同参的函数，但是实现只能写一个

接口：略

### 1.2. 类

```TS
class ClassName {
  private a: number; // 默认 public
  static b: number; // 用 ClassName.b 访问
  constructor() { this.a = 1; }
}
```

## 2. node-webkit

将 web 打包成桌面程序。
