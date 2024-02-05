# android

- [1. 控件](#1-控件)
  - [1.1. 下拉框](#11-下拉框)
  - [1.2. 输入框 EditText](#12-输入框-edittext)
  - [1.3. 文本框 TextView](#13-文本框-textview)
  - [1.4. 按钮 Button](#14-按钮-button)
  - [1.5. 图片 ImageView](#15-图片-imageview)
  - [1.6. 进度条 ProgressBar](#16-进度条-progressbar)
  - [1.7. 通知 Notifaction](#17-通知-notifaction)
  - [1.8. 工具栏 Toolbar](#18-工具栏-toolbar)
  - [1.9. 对话框](#19-对话框)
  - [1.10. 弹窗 PopupWindow](#110-弹窗-popupwindow)
  - [1.11. ListView](#111-listview)
  - [1.12. 滚动条 ScollView](#112-滚动条-scollview)
  - [1.13. 帧动画](#113-帧动画)
  - [1.14. 补间动画](#114-补间动画)
  - [1.15. 属性动画](#115-属性动画)
  - [1.16. layoutParams](#116-layoutparams)
  - [1.17. ViewPager](#117-viewpager)
  - [1.18. ViewPager2](#118-viewpager2)
- [2. 布局](#2-布局)
  - [2.1. 线性布局 LinearLayout](#21-线性布局-linearlayout)
  - [2.2. 帧布局 FrameLayout](#22-帧布局-framelayout)
  - [2.3. TableLayout](#23-tablelayout)
  - [2.4. GridLayout](#24-gridlayout)
  - [2.5. 约束布局 ConstraintLayout](#25-约束布局-constraintlayout)
- [3. fragment](#3-fragment)
  - [3.1. 创建切换](#31-创建切换)
  - [3.2. Bundle 通信](#32-bundle-通信)
  - [3.3. 接口通信](#33-接口通信)
- [4. Activity](#4-activity)
  - [4.1. 创建切换-1](#41-创建切换-1)
  - [4.2. Intent 通信](#42-intent-通信)
- [5. SQLite Room](#5-sqlite-room)
  - [5.1. 依赖](#51-依赖)
  - [5.2. JavaBean](#52-javabean)
  - [5.3. Dao](#53-dao)
  - [5.4. Database](#54-database)
  - [5.5. 使用](#55-使用)
- [6. SharedPreference](#6-sharedpreference)
- [7. 服务 Service](#7-服务-service)
  - [7.1. 创建运行](#71-创建运行)
  - [7.2. 生命周期](#72-生命周期)
- [8. 广播 Receiver](#8-广播-receiver)

## 1. 控件

### 1.1. 下拉框

创建：

```xml
<Spinner
    android:id="@+id/spinner"
    android:layout_width="..."
    android:layout_height="..."
    android:entries="@array/data"
    android:prompt="@string/spinner_name"
    android:spinnerMode="dialog" />
```

- `entries`: 数组，表示选项
- `prompt`: 类似标题

`/values/arrays.xml` 里

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string-array name="data">
        <item>北京</item>
        <item>上海</item>
        <item>武汉</item>
        <item>南京</item>
        <item>南昌</item>
    </string-array>
</resources>
```

### 1.2. 输入框 EditText

- `hint` 输入提示（placeholder）
- `textColorHint` 输入提示的颜色
- `inputType` 输入类型
- `padding` 内容和边框的间距（也可以用 `paddingLeft` 等）

图片

- `drawableLeft` 在左边放图片
- `drawablePadding` 图片和文字的间距

### 1.3. 文本框 TextView

属性

- `text` 内容（应当引用资源）`@string/blabla`
- `textColor` 字体颜色，`#FF000000` 前两位是不透明度（应当引用资源）`@color/black`
- `textStyle` 风格，`bold` 粗体 `italic` 斜体
- `textSize` 字体大小，单位 sp
- `background` 背景，可以设置为颜色或图片
- `gravity` 内容的对齐方式，`center` 正中间，`right, bottom, left, top`

阴影（指文本的阴影）

- `shadowColor` 阴影颜色，`@color/red`
- `shadowRadius` 阴影半径，`3.0`
- `shadowDx` 水平偏移，`10.0`
- `shadowDy` 垂直偏移，`10.0`

走马灯

- `lines` 行数，`1`（默认多行）（一行显示不下会打省略号）
- `ellipsize` 省略方式，`marquee` 即跑马灯
- `marqueeRepeatLimit` 字幕动画重复次数，`marquee_forever` 无限
- `focusable` 是否可以获取焦点，`true`
- `focusableInTouchMode` 在触控模式下是否可以聚焦，`true`
- 在 TextView 内放一个标签 `<requestFocus />` 自动获取焦点

脚本

`$TextView.setText(xx)` 设置显示文本

字符串格式化：

在 strings.xml 里 `<string name="name">%1$s %2$s</string>`

然后 `String.format(getResources().getString(R.string.name), s1, s2)` 来实现字符串格式化

### 1.4. 按钮 Button

继承自 TextView

属性

- background（没有效果要改 `values/themes` 中加个 Bridge `<style name="Theme.AndroidApp" parent="Theme.MaterialComponents.DayNight.DarkActionBar.Bridge">`）

事件

- `$button.setOnClickListener` 点击事件
- `$button.setOnLongClickListener` 长按事件
- `$button.setOnTouchListener` 触摸事件（会报奇奇怪怪的 warning）
- 短按：Touch 0, Touch 1, Click
- 长按：Touch 0, 固定时间, LongClick, 释放, Touch 1, Click
- 按下后移开，不管释放在哪都不触发 Click（？）

设置监听来添加按钮功能

```java
// 在 onCreate 方法中
Button btn = findViewById(R.id.button2); // 按钮 id
btn.setOnClickListener(view -> {
    Log.d(TAG, "onClick");
});

btn.setOnLongClickListener(view -> {
    Log.d(TAG, "onLongClick");
    return false; // 返回 true 将事件销毁（点击不触发）
});

bten.setOnTouchListener((view, event) -> {
    Log.d(TAG, "onTouch " + event.getAction()); // getAction 0 按下 1 释放 2 移动
    return false; // 返回 true 将事件销毁（点击和长按不触发）
});
```

### 1.5. 图片 ImageView

- `layout_width, layout_height` 为确定值？
- `src` 图片引用
- `scaleType` 填充方式
  - `fitXY` 适应宽高
  - `fitStart` 保持宽高比，不超出宽高？，左上角
  - `fitCenter` 保持宽高比，不超出宽高？，正中心
  - `fitEnd` 保持宽高比，不超出宽高？，右下角
  - `center` 原始大小，正中心
  - `centerCrop` 保持宽高比，刚好完全覆盖，正中心？
  - `centerInside` 保持宽高比，不超出宽高？，正中心
  - `fitCenter` ？
- adjustViewBounds 和 maxWidth, maxHeight 一起使用，效果未知

### 1.6. 进度条 ProgressBar

默认是一个在转的圈

- `style` 样式
  - `"?android:attr/progressBarStyleHorizontal"` 水平进度条，默认显示精确进度（设置 max 和 progress），不显示就类似转圈
- `max` 最大刻度 `100`
- `progress` 当前刻度 `0`
- `indeterminate` 不显示精确进度 `false`

```java
ProgressBar bar = findViewByid(R.id.blabla); // 得到进度条控件
if (bar.getVisibility() == View.GONE) {
    bar.setVisibility(View.VISIBLE);
}
// GONE 隐藏 VISIBLE 显示
// 隐藏会从布局中移除？
bar.setProgress(bar.getProgress() + 10); // 加进度
```

### 1.7. 通知 Notifaction

跳过

### 1.8. 工具栏 Toolbar

先在 themes.xml 里改成 NoActionBar `<style name="Theme.AndroidApp" parent="Theme.MaterialComponents.DayNight.NoActionBar.Bridge">`

```xml
<androidx.appcompat.widget.Toolbar
    android:id="@+id/toolbar"
    android:background="@color/blue"
    app:title="用户注册"
    app:titleTextColor="@color/white"
    android:layout_width="match_parent"
    android:layout_height="?attr/actionBarSize"
    app:layout_constraintStart_toStartOf="parent"
    app:layout_constraintTop_toTopOf="parent" />
```

- `navigationIcon` 导航图标的引用（一般是返回按钮）
- `title` 标题
- `titleTextColor` 标题文本颜色
- `titleMarginStart` 标题与左边界的距离
- `subtitle` 子标题（显示在主标题的下面）
- `subtitleTextColor` 子标题文本颜色
- `logo` 图标的引用

toolbar 里面可以放控件

`toolbar.setNavigationOnClickListener(view -> { ... });` 导航图标的点击事件（Toolbar 导包有坑，要选择 androidx）

### 1.9. 对话框

```java
AlertDialog.Builder builder = new AlertDialog.Builder(this);
builder.setIcon(R.mipmap.ic_launcher)
        .setTitle("标题")
        .setMessage("内容")
        .setPositiveButton("是", (dialog, which) -> {
        })
        .setNegativeButton("否", (dialog, which) -> {
        })
        .setNeutralButton("取消", (dialog, which) -> {
        })
        .create()
        .show();
```

- 可以不设置按钮
- a.xml 可以转换为 view：`getLayoutInflater().inflate(R.layout.a, null)`
- `.setView(view)` 会插入 Message 下方、按钮上方

### 1.10. 弹窗 PopupWindow

跳过

### 1.11. ListView

```xml
<ListView
    android:id="@+id/lv"
    android:layout_width="match_parent"
    android:layout_height="match_parent" />
```

新建 list_item.xml，定义每个元素

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical" >

    <TextView
        android:id="@+id/tv"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:textSize="30sp" />

</LinearLayout>
```

新建 MyAdapter.java，定义 adapter

```java
// ...

public class MyAdapter extends BaseAdapter {
    final private List<String> data;
    final private Context context;

    public MyAdapter(List<String> data, Context context) {
        this.data = data;
        this.context = context;
    }

    @Override
    public int getCount() {
        return data.size();
    }

    @Override
    public Object getItem(int i) {
        return null;
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder viewHolder;
        if (view == null) {
            viewHolder = new ViewHolder();
            view = LayoutInflater.from(context).inflate(R.layout.list_item, viewGroup, false);
            viewHolder.textView = view.findViewById(R.id.tv);
            view.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) view.getTag();
        }
        viewHolder.textView.setText(data.get(i));
        return view;
    }

    static private final class ViewHolder {
        TextView textView;
    }
}
```

- `getView()` 会不断调用
- `ViewHolder` 为了减少 findViewById 次数

最后加载的代码

```java
for (int i = 0; i < 100; i++) {
    data.add("" + i);
}

ListView listView = findViewById(R.id.lv);
listView.setAdapter(new MyAdapter(data, this));

listView.setOnItemClickListener(
    (parent, view, i, id) -> Log.d(TAG, "onItemClick" + i)
);
```

### 1.12. 滚动条 ScollView

空缺

### 1.13. 帧动画

在 drawable 里新建 resource file

```xml
<animation-list xmlns:android="...">
    <item android:drawable="@drawable/..." android:duration="120" />
    <item android:drawable="@drawable/..." android:duration="120" />
    ...
</animation-list>
```

- 该文件可以当成图片使用
- 每个 item 都是一帧，120 表示毫秒

```java
RelativeLayout layout = findViewById(R.id.rl);
AnimationDrawable anim = (AnimationDrawable)layout.getBackground();
anim.start(); // 启动动画
anim.stop(); // 停止动画
```

### 1.14. 补间动画

创建 /src/main/res/anim 文件夹，然后创建文件 Resource File（alpha.xml）

- 不透明度从 0 到 1 的 2 秒动画

```xml
<?xml ...?>
<set xlmns:android="...">
    <alpha
        android:fromAlpha="0"
        android:toAlpha="1"
        android:duration="2000" />
</set>
```

弄一个 ImageView

```java
ImageView imageView = findViewById(R.id...); // 获取 ImageView
Animation animation = AnimationUtils.loadAnimation(MainActivity.this, R.anim.alpha);
imageView.startAnimation(animation);
```

旋转

- 0 到 360 度，绕点 (50%, 50%) 旋转的 2 秒动画

```xml
<rotate
    android:fromDegrees="0"
    android:toDegrees="360"
    android:pivotX="50%"
    android:pivotY="50%"
    android:duration="2000" />
```

缩放

- 从原始大小缩小到一半，原点为 (50%, 50%) 的 2 秒动画

```xml
<scale
    android:fromXScale="1"
    android:fromYScale="1"
    android:toXScale="0.5"
    android:toYScale="0.5"
    android:pivotX="50%"
    android:pivotY="50%"
    android:duration="2000" />
```

平移

- 从原始位置平移到 (400, 0) 的 2 秒动画

```xml
<translate
    android:fromXDelta="0"
    android:fromYDelta="0"
    android:toXDelta="400"
    android:toYDelta="0"
    android:duration="2000" />
```

### 1.15. 属性动画

ValueAnimator

```java
// in onCreate
ValueAnimator valueAnimator = ValueAnimator.ofFloat(0f, 1f); // 从 0 到 1 的 float
valueAnimator.setDuration(2000); // 设置时间为 2 秒
valueAnimator.addUpdateListener(animation -> {
    float value = animation.getAnimatedValue();
    // 这里将 view 的属性设为 value
});
valueAnimator.start(); // 开始动画
```

ObjectAnimator

```java
TextView textView = findViewById(R.id...);
ObjectAnimator objectAnimator = ObjectAnimator.ofFloat(textView, "alpha", 0f, 1f); // 参数为控件名，属性名，起点，终点（属性名小写，会自动找到 getAlpha 方法）
objectAnimator.setDuration(2000);
objectAnimator.start();

objectAnimator.addListener(new Animator.AnimatorListener() {...}); // 包含动画开始、结束、取消、重复执行
```

### 1.16. layoutParams

```java
// 新建 LinearLayout
LinearLayout linearLayout = new LinearLayout(this);
LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
linearLayout.setLayoutParams(layoutParams);
// 新建 TextView
TextView textView = new TextView(this);
textView.setText("233");
textView.setBackgroundColor(0xffff0000);
LinearLayout.LayoutParams textLayoutParams = new LinearLayout.LayoutParams(300, 300);
textView.setLayoutParams(textLayoutParams);
// 放入 LinearLayout
linearLayout.addView(textView);
// 放入 Activity
setContentView(linearLayout);
```

### 1.17. ViewPager

新建 src/main/java/com..../MyAdapter.java

```java
public class MyAdapter extends PagerAdapter {
    private List<View> mListView;

    public MyAdapter(List<View> mListView) {
        this.mListView = mListView;
    }

    @override
    public Object instanceItem(@NonNull ViewGroup container, int position) {
        container.addView(mListView.get(position), 0);
        return mListView.get(position);
    }

    @override
    public int getCount() {
        return mListView.size(); // 有几个 view
    }

    @override
    public boolean isViewFromObject(@NonNull View view, @NonNull Object object) {
        return view == object;
    }

    @override
    public void destroyItem(@NonNull ViewGroup container, int position, @NonNull Object object) {
        container.removeView(mListView.get(position));
    }
}
```

```java
// onCreate
LayoutInflater lf = getLayoutInflater().from(this);
List<View> viewList = new ArrayList<>();
viewList.add(lf.inflate(R.layout...));
viewList.add(lf.inflate(R.layout...));
viewList.add(lf.inflate(R.layout...));

ViewPager viewPager = findViewById(R.id.vp);
MyAdapter myAdapter = new MyAdapter(viewList);
viewPager.setAdapter(myAdapter)
```

### 1.18. ViewPager2

在 Gradle Scripts -> build.gradle (Module ...) 中的依赖里添加 `implementation 'androidx.viewpager2:viewpager2:1.0.0'`

特点：懒加载、基于 RecyclerView

```xml
<androidx.viewpager2.widget.ViewPager2
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:id="@+id/viewPager">
</androidx.viewpager2.widget.ViewPager2>
```

适配器要继承 `RecyclerView.Adapter`

？？？

## 2. 布局

### 2.1. 线性布局 LinearLayout

- `orientation` 方向，vertical 垂直 / horizontal 水平（默认）
- `gravity` 对齐方向 `center / center_vertical / ...`，用 | 来指定两个方向
- `layout_gravity`
- `background`
- `layout_weight` 子元素属性，将剩余空间根据权重分配

分割线（没什么用）

- `divider` 分割线，是一个图片引用
- `showDivider` 显示分割线，`none` 无 `beginning` 最前 `end` 最后 `middle` 每两个子元素之间
- `dividerPadding` 分割线与边界的距离

### 2.2. 帧布局 FrameLayout

- 所有控件都放置在左上角
- 写在后面的控件覆盖前面的

### 2.3. TableLayout

```xml
<TableLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <TableRow>
        <!-- ... -->
    </TableRow>
</TableLayout>
```

- `stretchColumns` 允许被拉伸的列，剩余空间将分配到这些列，`0,1`
- `shrinkColumns` 允许被收缩的列，只有超出了才会收缩

TableRow 的子元素的属性

- `layout_column` 显示在第几列
- `layout_span` 横跨几列

### 2.4. GridLayout

- `orientation` 水平（默认） / 垂直
- `columnCount` 当水平排布时，一行多少列后换行
- `rowCount` 当垂直排布时，一列多少行后换列

子元素属性

- `layout_column` 显示在第几列
- `layout_columnSpan` 横跨几列
- `layout_columnWeight` 剩余空间分配权值
- column 改成 row 同样有效

### 2.5. 约束布局 ConstraintLayout

打开 Design 视图，把一个个控件拖进去

控件的四个角可以缩放，但是会把 layout_width, layout_height 改为确定值

控件的上下左右四个圆圈可以指定它位置的约束

指导线（面板上面的最后一个按钮）：点击圆的最下面，可以改变约束（左 / 右 / 百分比）

推导约束（指导线左边一个按钮）：所见即所得了属于是

layout_width, layout_height：

- wrap_content: 包裹内容
- match_parent: 匹配父级的宽或高
- 0dp: 匹配约束
- 或填入确定值 100dp 等

id

- `@+id/blabla`
- 用 `findViewById(R.id.blabla)` 获取控件

## 3. fragment

### 3.1. 创建切换

在 com.xxx.xxx 文件夹右击 -> New -> Fragment -> Fragment (blank)

然后类可以简化为

```java
public class Fragment1 extends Fragment {

    private View root;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        if (root == null) {
            root = inflater.inflate(R.layout.fragment_1, container, false);
        }
        return root;
    }
}
```

xml 写起来和 Activity 一样

然后在 Activity 里写 androidx.fragment.app.FragmentContainerView 即可（id 必须有）

```xml
<androidx.fragment.app.FragmentContainerView
    android:id="@+id/fragment1"
    android:name="com.example.androidproject.Fragment1"
    android:layout_width="match_parent"
    android:layout_height="match_parent" />
```

动态切换 fragment

```java
private void replaceFragment(Fragment fragment) {
    FragmentManager fragmentManager = getSupportFragmentManager();
    FragmantTransaction transaction = fragmentManager.beginTransaction();
    transaction.replace(R.id.layout, fragment);
    transaction.addToBackStack(null);
    transaction.commit();
}
replaceFragment(new Fragment1());
```

addToBackStack 会把该 fragment 压入事务栈

### 3.2. Bundle 通信

在 activity 里

```java
Bundle bundle = new Bundle();
bundle.putString("message", "233"); // key, value
Fragment1 fragment = new Fragment1();
fragment.setArguments(bundle);
replaceFragment(fragment);
```

在 fragment 里（任意方法，比如 onCreateView）

```java
Bundle bundle = getArguments();
if (bundle != null) {
    bundle.getString("message");
}
```

### 3.3. 接口通信

先创建一个接口 IFragmentCallback

```java
// package ...;

public interface IFragmentCallback {
    void send(String msg);
    String receive();
}
```

fragment 里新建属性 `private IFragmentCallback callback`，新建方法 `public void setFragmentCallback(cb) { callback = cb; }`

然后创建匿名类对象传给 fragment

```java
var fragment = new ...();
fragment.setFragmentCallback(new IFragmentCallback() {
    @Override
    public void send(String msg) {
        // 相当于提交了事件，可以写该事件的处理逻辑
    }

    @Override
    public String receive() {
        return null;
    }
});
```

发送时直接 `callback.send("xxx")` 即可

## 4. Activity

在 manifest 里用 intent-filter（激活 Activity 的操作）标记了首次启动的 Activity

### 4.1. 创建切换-1

创建

new empty activity，自动完成：创建 .java、.xml，在 manifest 里注册

切换

```java
startActivity(new Intent(this, NewActivityName.class));
```

### 4.2. Intent 通信

创建者

```java
Intent intent = new Intent(this, NewActivityName.class);
{
    Bundle bundle = new Bundle();
    bundle.putString("data", "xxx");
    intent.putExtras(bundle);
}
startActivity(intent);
```

被创建者

```java
Intent intent = getIntent();
String name = intent.getStringExtra("data");
```

## 5. SQLite Room

数据类型

- NULL
- INTEGER 整数
- REAL 浮点
- TEXT 字符串文本
- BLOB 二进制对象

名称不区分大小写

### 5.1. 依赖

```text
dependencies {
    def room_version = "2.4.2"

    implementation "androidx.room:room-runtime:$room_version"
    annotationProcessor "androidx.room:room-compiler:$room_version"

    // optional - RxJava2 support for Room
    implementation "androidx.room:room-rxjava2:$room_version"

    // optional - RxJava3 support for Room
    implementation "androidx.room:room-rxjava3:$room_version"

    // optional - Guava support for Room, including Optional and ListenableFuture
    implementation "androidx.room:room-guava:$room_version"

    // optional - Test helpers
    testImplementation "androidx.room:room-testing:$room_version"

    // optional - Paging 3 Integration
    implementation "androidx.room:room-paging:2.5.0-alpha01"
}
```

### 5.2. JavaBean

定义一个映射对象

```java
@Entity(tableName = "users")
public class User {
    @PrimaryKey(autoGenerate = true)
    public int id;

    @ColumnInfo(name = "first_name")
    public String firstName;

    @ColumnInfo(name = "last_name")
    public String lastName;
}
```

- `@Entity` 标记一个 Room 实体
- `@PrimaryKey` 主键，`autoGenerate` 自动生成

### 5.3. Dao

Dao 用于描述操作数据的方式

```java
@Dao
public interface UserDao {
    @Query("SELECT * FROM user")
    List<User> getAllUsers();

    @Query("SELECT * FROM user WHERE id=:id")
    User getUser(int id);

    @Insert
    void insert(User... users);

    @Update
    void update(User... users);

    @Delete
    void delete(User... users);
}
```

### 5.4. Database

```java
@Database(entities = { User.class }, version = 1, exportSchema = false)
public abstract class UserDatabase extends RoomDatabase {

    private static final String DB_NAME = "UserDatabase.db";
    private static volatile UserDatabase instance;

    public static synchronized UserDatabase getInstance(Context context) {
        if (instance == null) {
            instance = create(context);
        }
        return instance;
    }

    private static UserDatabase create(final Context context) {
        return Room.databaseBuilder(
            context,
            UserDatabase.class,
            DB_NAME)
                .allowMainThreadQueries()
                .build();
    }

    public abstract UserDao getUserDao();
}
```

### 5.5. 使用

```java
User user = new User();
user.firstName = "1";
UserDatabase.getInstance(getApplication()).getUserDao().insert(user);
```

## 6. SharedPreference

写

```java
Context context = getApplication();
SharedPreferences sharedPref = context.getSharedPreferences(
        "hjt", Context.MODE_PRIVATE);
SharedPreferences.Editor editor = sharedPref.edit();
editor.putInt("num", 1);
editor.apply();
```

读

```java
Context context = getApplication();
SharedPreferences sharedPref = context.getSharedPreferences(
        "hjt", Context.MODE_PRIVATE);
int num = sharedPref.getInt("num", -1); // 第二个参数是不存在时的返回值
```

## 7. 服务 Service

服务可以在后台默默运行

### 7.1. 创建运行

new Service

类似 Activity 的启动方法

```java
startService(new Intent(this, NewServiceName.class));
```

停止服务

```java
stopService(new Intent(this, NewServiceName.class));
```

### 7.2. 生命周期

onStart（startService 时调用）

onDestroy（stopService 时调用）

## 8. 广播 Receiver

系统广播，比如 开机、网络连接和断开、电池电量低 等

用户自定义广播
