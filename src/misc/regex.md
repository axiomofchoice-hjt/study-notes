# regex

[[toc]]

## 1. 字符

- `[0-9a-zA-Z]` 匹配一个数字或字母
- `[^a-z]` 匹配一个非字母字符
- `\d` 匹配一个数字，`\D` 匹配一个非数字
- `.` 匹配换行符外的任意字符
- `\w` 匹配字母、数字、下划线或汉字，`\W` 匹配非字母、数字、下划线或汉字
- `\s` 匹配一个空白符，`\S` 匹配非空白符
- `\b` 匹配单词分界处（零长度），`\B` 匹配非单词分界处（零长度）
- `^` 匹配一行的开始（零长度）
- `$` 匹配一行的结束（零长度）
- 所有字符：`[\s\S]`

## 2. 限定符

加在字符后表示匹配一定数目的字符

- `*` 重复 0+ 次
- `+` 重复 1+ 次
- `?` 重复 0/1 次
- `{n}` 重复 n 次
- `{n,}` 重复 n+ 次
- `{n,m}` 重复 n..m 次

贪婪
  
- 限定符 `*`, `+` 会尽可能多地匹配
- 限定符 `*?`, `+?` 会尽可能少地匹配

## 3. 后向引用

- `(exp)` 匹配并对文本编号，编号从 1 开始（匹配的内容加载进缓存）
- `\n` $(n=1,2,...)$ 重复对应编号的文本
- `(?<name>exp)` 匹配并对文本命名（匹配的内容加载进缓存）
- `\k<name>` 重复对应名字的文本
- `(?=exp)` 匹配 exp 前的位置（零长度），`(?!exp)` 匹配非 exp 前的位置（零长度）
- `(?<=exp)` 匹配 exp 后的位置（零长度），`(?<!exp)` 匹配非 exp 后的位置（零长度）
- `(?:exp)` 仅匹配，不加载进缓存
- `(?#note)` 注释

## 4. 递归

有相关语法，但一般不支持

## 5. 常用模板

- 匹配 `(abc^def)`：`(?<=abc)(?=def)`，反匹配就把 "=" 改成 "!"
- `repeat\s*\(\s*(.+),\s(.+),\s(.+)\)` `for (int \1 = \2, _ = \3; \1 < \3; \1++)`
- `[^\u0000-\u007F]` 非 ASCII 字符
