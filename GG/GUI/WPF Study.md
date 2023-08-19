# WPF

- [1. 可视化](#1-可视化)
- [2. 布局](#2-布局)
- [3. 样式](#3-样式)
- [4. 事件](#4-事件)

## 1. 可视化

- 视图 -> 工具箱，拖控件到窗口里

## 2. 布局

StackPanel

- 默认垂直方向排列，改 Orientation 得到水平
- 貌似在另一方向默认居中

```xml
<Grid>
    <StackPanel Orientation="Horizontal">
        <Button Width="40" Height="40" />
        <Button Width="40" Height="40" />
        <Button Width="40" Height="40" />
    </StackPanel>
</Grid>
```

WrapPannel

- 类似 web 的文档流，自动换行

DockPannel

- 将元素靠边
- 默认最后一个元素填充满，即 `LastChildFill="True"`

```xml
<Grid>
    <DockPanel LastChildFill="False">
        <Button Width="40" Height="40" DockPanel.Dock="Top" />
        <Button Width="40" Height="40" DockPanel.Dock="Bottom" />
        <Button Width="40" Height="40" DockPanel.Dock="Left" />
        <Button Width="40" Height="40" DockPanel.Dock="Right" />
    </DockPanel>
</Grid>
```

Grid

- 相当于表格

```xml
<Grid>
    <Grid.RowDefinitions> <!-- 2 行 -->
        <RowDefinition />
        <RowDefinition />
    </Grid.RowDefinitions>
    <Grid.ColumnDefinitions> <!-- 3 列 -->
        <ColumnDefinition />
        <ColumnDefinition Width="2*" /> <!-- -->
        <ColumnDefinition />
    </Grid.ColumnDefinitions>
    <Border Grid.Row="0" Grid.Column="1" Background="Blue" />
</Grid>
```

## 3. 样式

```xml
<Window.Resources>
    <Style x:Key="defaultStyle" TargetType="Button">
        <Setter Property="FontSize" Value="64" />
        <Setter Property="Height" Value="100" />
        <Setter Property="Width" Value="200" />
        <Setter Property="Foreground" Value="White" />
        <Setter Property="Background" Value="Gray" />
        <Setter Property="Content" Value="233" />
        <!-- 触发器，当鼠标停留在按钮上时，字体颜色改为绿色 -->
        <Style.Triggers>
            <Trigger Property="IsMouseOver" Value="True" >
                <Setter Property="Foreground" Value="Green" />
            </Trigger>
        </Style.Triggers>
    </Style>
</Window.Resources>
<Grid>
    <Button Style="{StaticResource defaultStyle}" />
</Grid>
```

- MultiTrigger 可以实现多条件触发
- EventTrigger 可以触发动画？

## 4. 事件

```xml
<Grid MouseUp="Grid_MouseUp">
</Grid>
```

在输入引号后按 Tab 自动创建方法
