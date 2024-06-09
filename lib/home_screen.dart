import 'package:flutter/material.dart';
import 'package:hive_db/add_todo.dart';
import 'package:hive_db/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
/*  ///For CRUD operation
  Box friendBox = Hive.box('friend');
  String? name;

  addFriend() async {
    await friendBox.put('name', 'Sk Hasan');
  }

  getFriend() async {
    setState(() {
      name = friendBox.get('name');
    });
  }

  updateFriend() async {
    await friendBox.put('name', 'Rockybul Rasel');
  }

  deleteFriend() async {
    await friendBox.delete('name');
  }*/

  /// For final ToDO application
  Box todoBox = Hive.box<Todo>('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Todo"),
      ),

/*      /// for CRUD
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text("$name"),
            ElevatedButton(onPressed: addFriend, child: const Text("Create")),
            ElevatedButton(onPressed: addFriend, child: const Text("Read")),
            ElevatedButton(onPressed: addFriend, child: const Text("Update")),
            ElevatedButton(onPressed: addFriend, child: const Text("Delete")),
          ],
        ),
      ),*/

      /// for ToDo Application
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
         builder: (context,Box box,widget){
            if(box.isEmpty){
              return const Center(
                child: Text("No Todo available !"),
              );
            }else{
              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: box.length,
                itemBuilder: (context,index){
                  Todo todo = box.getAt(index);
                  return ListTile(
                    title: Text(todo.title,style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: todo.isCompleted ? Colors.green : Colors.black,
                      decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none
                    ),),
                    leading: Checkbox(value: todo.isCompleted, onChanged: (value){
                       Todo newTodo = Todo(
                         title: todo.title,
                         isCompleted: value!,
                       );

                       box.putAt(index, newTodo);
                    }),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete,color: Colors.red,),
                      onPressed: (){
                         box.deleteAt(index);
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Todo deleted Successfully !"),));
                      },
                    ),

                  );

                });
            }
         }),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddTodo()));
        },
      ),
    );
  }
}
