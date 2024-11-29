class ToDo {
  String? id;
  String? todoText;
  DateTime taskDate;
  bool isDone;


  ToDo({
    required this.id,
    required this.todoText,
    required this.taskDate,
    this.isDone = false,
  });


static List<ToDo> todoList() {
  return [
    ToDo( id: '01', todoText: 'Task 1', taskDate: DateTime.now(), isDone: true),
    ToDo( id: '02', todoText: 'Task 2', taskDate: DateTime.now(), isDone: true),
    ToDo( id: '03', todoText: 'Task 3', taskDate: DateTime.now(), isDone: false),
    ToDo( id: '04', todoText: 'Task 4', taskDate: DateTime.now(), isDone: false),
    ToDo( id: '05', todoText: 'Task 5', taskDate: DateTime.now(), isDone: false),
    ToDo( id: '06', todoText: 'Task 6', taskDate: DateTime.now().add(Duration(days:1))),
  ];
}
}