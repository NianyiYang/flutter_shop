# flutter_shop

移动电商实战

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## 一个坑点

如果要使用本地服务，例如 JsonServer ，Dio 有bug ，需要转换一下端口

执行 `adb reverse tcp:3031 tcp:3031` ，其中3031 是你本地服务的端口号
