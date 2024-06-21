import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'JsonModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<JsonModelClass> toDoList = [];

  Future<List<JsonModelClass>> getApi() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        toDoList.add(JsonModelClass.fromJson(i));
      }
      return toDoList;
    } else {
      return toDoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("API Practice"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: toDoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(toDoList[index].title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('User ID: ${toDoList[index].userId}'),
                              Text('ID: ${toDoList[index].id}'),
                              Text('Completed: ${toDoList[index].completed}'),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ));
  }
}