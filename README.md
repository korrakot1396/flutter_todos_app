# flutter_gin_todo_app

![](https://github.com/korrakot1396/flutter_todos_app/blob/main/pv_1.png)
# organizer

| nickname | full-name           | github username |
| -------- | ------------------- | --------------- |
| Tiger    | Korrakot Triwichian | korrakot1396    |

## Project installation process

_For server_

```shell
clone https://github.com/korrakot1396/golang-gin-todos.git from https://github.com/korrakot1396/golang-gin-todos
cd golang-gin-todos
go mod download
go mod tidy
go run cmd/main.go
```

_For frontend_

```shell
clone https://github.com/korrakot1396/flutter_todos_app.git
cd flutter_todos_app
make sure fvm install
fvm flutter build
fvm flutter pub get
fvm flutter pub outdated
fvm flutter run
```

## Configuration for run on localhost need to config your-ip-address

_Config test on local_

```shell
open terminal
command 'ifconfig' for check your-ip-address
cd flutter_todos_app
go to lib/services/todo_service.dart
change to your-ip-address for test on local
```

## Configuration for run on localhost need to config your-ip-address

_Config declarative plugins block_

```
go to android/build.gradle 
update to line => ext.kotlin_version = '1.7.0'
update dependencies => classpath 'com.android.tools.build:gradle:7.3.0'
go to android/gradle/wrapper/graddle-wrapper.properties 
update to line => distributionUrl=https\://services.gradle.org/distributions/gradle-7.6.3-all.zip
```


![](https://github.com/korrakot1396/flutter_todos_app/blob/main/config.png)

## Demo
![](https://github.com/korrakot1396/flutter_todos_app/blob/main/pv_2.png)
![](https://github.com/korrakot1396/flutter_todos_app/blob/main/pv_3.png)
![](https://github.com/korrakot1396/flutter_todos_app/blob/main/demo_1.png)

