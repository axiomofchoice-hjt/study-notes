# unity2d

- [1. 配置](#1-配置)
- [2. 准备](#2-准备)

## 1. 配置

- 修改脚本打开方式：Edit -> Preferences -> External Tools -> 第一个选项卡

## 2. 准备

- 修改背景颜色：Camera 游戏物体 -> Camera 组件 -> Background
- 修改摄像头大小：Camera 游戏物体 -> Camera 组件 -> Size
- 修改摄像头长宽比：Game 视图 -> 左上角，从左往右第二个选项卡
- 缩小摄像头：Scene 视图 -> 右上角 Gizmos 展开 -> 最上面的滑动条往左到底

***

- 从 Project 视图拖动图片到 Hierarchy 视图创建一个物体
- 这样创建的物体的 Sprite Renderer -> Sprite 可以修改图片（将 Project 视图的图片拖到它上面）
- 改完后拖进 Prefabs 文件夹作为预制体
- 在 Hierarchy 进行的修改不会保存到预制体里，需要点击右上方的 Overrides -> Apply All

***

- 从 Project 视图选中多张图片后拖进 Hierarchy 视图创建一个动画
- 会要求创建两个文件，三角形的是动画，另一个是动画控制器
- 再拖进 Prefabs 文件夹作为预制体

***

- 碰撞条件：双方都有碰撞器、至少一方是刚体（一般是运动的那个）
- 添加碰撞器：Inspector 界面 -> Add Component -> Physics 2D -> Box Collider 2D
- 添加刚体：...... -> Physics 2D -> Rigidbody 2D
  - Gravity Scale 表示重力，可设为 0
  - Constraints 里第三个框可以锁住旋转
- 添加组件时可以选中多个

***

- 触发器就是碰撞器里勾选 is trigger，同时添加刚体
- 碰撞不受力
- 碰撞事件 `private void OnTriggerEnter2D(Collider2D other)` 或者 Stay 或者 Exit

***

在 Sprite Renderer 组件 -> Additional Settings 中

- Sorting Layer 是大层级
- Order in Layer 是小层级，越大优先级越高
- 都是控制 z-index 的

***

- `private void Awake()` 也是初始化
- `private void FixedUpdate()` 固定时间间隔的 update
  - 玩家移动时撞墙会鬼畜，将位移的代码写进该函数可以避免（但是会进墙的问题还是没解决）

```cs
// 修改显示的图片
private SpriteRenderer sr;
public Sprite[] tankSprite; // 通过 Unity 编辑器拖动图片到组件上
private void Awake()
{
    sr = GetComponent<SpriteRenderer>();
}
void Update() {
    // ...
    sr.sprite = tankSprite[0]; // 修改显示的图片
    // ...
}
```

***

如何创建实例：

- `public GameObject bulletPrefab;`
- 将预制体拖到该变量上
- `Instantiate(bulletPrefab, transform.position, transform.rotation);`

销毁自己 `Destroy(gameObject);` 第二个参数可以填多少秒以后。`Destroy(collision.gameObject);` 销毁碰撞物体

***

键盘 `if (Input.GetKeyDown(KeyCode.Space))` （注意要放到 Update() 里）

***

碰撞物体 tag：`collision.tag`

调用碰撞物体的方法 `collision.SendMessage("xxx");` 但是也可以 `collision.GetComponent<脚本名>().xxx();`

***

隐藏：`xxx.SetActive(false);`

***

延时调用 `Invoke("BornTank", 0.8f);`，BornTank 是该类的一个方法

***

新建场景：Ctrl + N，然后保存一下，拖动到 Scene 文件夹里

切换场景 `using UnityEngine.SceneManagement`，然后 `SceneManager.LoadScene(1);`

***

音效

`public AudioClip dieAudio;` 拖动赋值，`AudioSource.PlayClipAtPoint(dieAudio, transform.position);`

***

- Screen 坐标：屏幕左下角 (0, 0)，右上角 (W, H)
- Viewport 坐标：屏幕左下角 (0, 0)，右上角 (1, 1)
- World 坐标：世界坐标
- Input.mousePosition 得到鼠标位置
- Camera.main.WorldToViewportPoint(Input.mousePosition)
- Camera.main.WorldToScreenPoint(Input.mousePosition)
- Camera.main.ViewportToScreenPoint(Input.mousePosition)
- Camera.main.ViewportToWorldPoint(Input.mousePosition)
- Camera.main.ScreenToViewportPoint(Input.mousePosition)
- Camera.main.ScreenToWorldPoint(Input.mousePosition)
- 拿到后 z 轴可能要赋值
