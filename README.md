# flutter_shop

移动电商实战

## 笔记

AutomaticKeepAliveClientMixin 混入 保持页面状态

不过使用使用这个属性是有几个先决条件的：

- 使用的页面必须是StatefulWidget,如果是StatelessWidget是没办法办法使用的。
- 其实只有两个前置组件才能保持页面状态：PageView和IndexedStack。
- 重写wantKeepAlive方法，如果不重写也是实现不了的。



## 优点

我们只需要Dart这一种语言，就可以编写页面和前台的业务逻辑。不再像使用前端技术时，要会js、html、css还要会框架

## 坑点

如果要使用本地服务，例如 JsonServer ，Dio 有bug ，需要转换一下端口。执行 `adb reverse tcp:3000 tcp:3000` ，其中 3000 是你本地服务的端口号

Dio bug : 如果后端返回数据格式是 json ，Dio 需要加入如下参数

```
  options: Options(
    responseType: ResponseType.json,
  ),
``` 


