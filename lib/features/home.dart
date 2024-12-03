import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unit4_exercise/utils/colors.dart';
import 'package:unit4_exercise/features/todo_item.dart';
import 'package:unit4_exercise/utils/styles.dart';
import 'package:unit4_exercise/features/todo.dart';

// This is the Home Screen

class Home extends StatefulWidget {
  Home ({Key? key}) : super(key: key);
 

 @override
 State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCalendar(),
          Expanded(
            child: Stack(
                children: [
                  Container(
                     padding: EdgeInsets.symmetric(horizontal : 20, vertical: 15,),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                      top: 50, 
                      bottom: 20),
                      child: Text('All To-Dos',
                       style: TextStyle(  
                        fontSize: 30, 
                        fontWeight: FontWeight.w500
                        ),
                    ),
                    ),
                    // Iterates To Do list and display
                    for ( ToDo todoo in _foundToDo.reversed )
                    ToDoItem(
                      todo: todoo,
                      onToDoChanged: _handleToDoChange,
                      onDeleteItem: _deleteToDoItem,
                      ),
                  ],
                ),
                )
              ],
            ),
            ),
                
         
            // Here is the input for adding to do
            Align(
              alignment: Alignment.bottomCenter, 
              child: Row(children: [ 
                Expanded( 
                  child: Container(
                margin: EdgeInsets.only(
                  bottom: 20, 
                  right:20, 
                  left:20,
                  ),
                  padding:EdgeInsets.symmetric(
                    horizontal: 20, 
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ), 
                  ],
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo list',
                      border: InputBorder.none
                    ),
                  ),
                  ),
                ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child:ElevatedButton(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      onPressed: () {
                        _addToDoItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      ),
                    ),
                  ),
              ]),
              ),
        ],
      ),
    ),
    ],
    ),
    );
}

  // Here is the calendar to choose dates
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: _selectedDate,
      selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
      onDaySelected: (selectedDay, focusedDay) {
        setState( () {
          _selectedDate = selectedDay;
        });
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: tdBlue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: tdBlue.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        ),
        headerStyle: HeaderStyle(formatButtonVisible: false),
    );
  }


//Toggles To Do
  void _handleToDoChange(ToDo todo){
    setState((){
      todo.isDone = !todo.isDone;
    });
  }

//Deletes a To Do
  void _deleteToDoItem(String id){
    setState((){
      todosList.removeWhere((item) => item.id == id);
    });
  }

//Adds a To Do
  void _addToDoItem(String toDo){
    if (toDo.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a task')),
      );
      return;
    }

    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(), 
        todoText: toDo,
        taskDate: _selectedDate, // Task add with selected date
        ));
    });
    _todoController.clear();
  }
  //Filters for search and selected date
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = todosList.where((todo) {
      return todo.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase()) &&
          isSameDay(todo.taskDate, _selectedDate);
    }).toList();

    setState(() {
      _foundToDo = results;
    });
  }

  //Gets tasks for selected date
  List<ToDo> _getTasksForSelectedDate() {
    return todosList.where((todo) {
      return isSameDay(todo.taskDate, _selectedDate);
    }).toList();
  }

  //Search box with text input for filtering
  Widget searchBox() {
    return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search, 
                  color: tdBlack, 
                  size: 20, 
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 20, 
                    minWidth: 25,
                    ),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: tdGray),
              ),
            ),
            );
  }


  //Here is the app bar with menu icons
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 45,
            width: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.asset('assets/profile-image.png'),
            ),
          ),
        ],
      ),
    );
  }
}