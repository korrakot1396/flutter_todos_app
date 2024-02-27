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

## Functionality

1. CRUD Operations: Implement complete CRUD operations for managing todos, including viewing, creating, updating, and deleting tasks.
2. Create Todos: Provide a user-friendly interface for users to create new todos with relevant details such as title, description, date, and optional image upload.
3. Mark Task as Done: Allow users to mark tasks as done, triggering a visual change in the app interface and updating the status of the task on the backend.
4. Image Upload: Enable users to upload images associated with their tasks. Ensure that images are converted to base64 format on the frontend before being sent to the backend API.
5. Cross-Platform App: Utilize Flutter framework to develop a mobile app that works seamlessly across different platforms, including iOS and Android.
6. Sorting Options: Implement sorting functionality to allow users to organize their tasks based on title, status, and date. Provide intuitive controls for sorting order (ascending/descending).
7. Delete Task: Allow users to delete tasks they no longer need. Implement a confirmation dialog to prevent accidental deletions.
8. Image Preview: Offer users the ability to preview images before uploading them. This feature enhances user experience by allowing them to verify the selected image before final submission.


![](https://github.com/korrakot1396/flutter_todos_app/blob/main/config.png)

## Demo
![](https://github.com/korrakot1396/flutter_todos_app/blob/main/pv_2.png)
![](https://github.com/korrakot1396/flutter_todos_app/blob/main/pv_3.png)
![](https://github.com/korrakot1396/flutter_todos_app/blob/main/demo_1.png)

