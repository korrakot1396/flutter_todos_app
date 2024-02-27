# flutter_gin_todo_app

![](https://github.com/korrakot1396/flutter_todos_app/blob/main/preview_1.png)
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

_Config_

```shell
open terminal
command 'ifconfig' for check your-ip-address
cd flutter_todos_app
go to lib/services/todo_service.dart
change to your-ip-address for test on local
```

![](https://github.com/korrakot1396/flutter_todos_app/blob/main/config.png)

_Demo_
![](https://github.com/korrakot1396/flutter_todos_app/blob/main/demo_1.png)
![](https://github.com/korrakot1396/flutter_todos_app/blob/main/demo_2.png)
![](https://github.com/korrakot1396/flutter_todos_app/blob/main/demo_3.png)

