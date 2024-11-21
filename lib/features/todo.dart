class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });


static List<ToDo> todoList() {
  return [
    ToDo( id: '01', todoText: 'Task 1', isDone: true),
    ToDo( id: '02', todoText: 'Task 2', isDone: true),
    ToDo( id: '03', todoText: 'Task 4', ),
    ToDo( id: '04', todoText: 'Task 4', ),
    ToDo( id: '05', todoText: 'Task 5', ),
    ToDo( id: '05', todoText: 'Task 6', ),
  ];
}
}