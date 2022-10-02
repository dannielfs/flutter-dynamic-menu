import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'MenuItemPage.dart';
import './models/MenuItemCustom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  static Future<List<MenuItemCustom>>? futureMenuItems;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Widget> listOfItems = <Widget>[];

  void _incrementCounter() {
    setState(() {
      _counter++;
      this.listOfItems.add(ListTile(
            title: Text('Item'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuItemPage(id: 1)),
              );
            },
          ));
    });
  }

  @override
  void initState() {
    super.initState();
    MyHomePage.futureMenuItems = getMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      drawer: Drawer(
          child: FutureBuilder(
              future: MyHomePage.futureMenuItems,
              builder: (context, AsyncSnapshot<List<MenuItemCustom>> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {

                  return ListView(
                      children: List.generate(snapshot.data!.length, (index) {
                    return ListTile(
                      title: Text(snapshot.data![index].title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuItemPage(id: snapshot.data![index].id)),
                        );
                      },
                    );
                  }));
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<List<MenuItemCustom>> getMenuItems() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
  if (response.statusCode == 200) {
    List<MenuItemCustom> values = List<MenuItemCustom>.from(json
        .decode(response.body)
        .map((data) => MenuItemCustom.fromJson(data)));

    // lets print out the title property
    values.forEach((element) {
      print(element.title);
    });
    return values;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
