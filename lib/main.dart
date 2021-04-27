import 'package:flutter/material.dart';
import 'crud.dart';

Crud crud = new Crud();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _createMemo() async {
    await crud.insert(title: "title", text: "content", tag: 2);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "ALL"
              ),
              Tab(
                text: "STUDY"
              ),
              Tab(
                text: "SHOP"
              ),
              Tab(
                text: "OTHERS"
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Text('all'),
            Text('study'),
            Text('shopping'),
            Text('others')
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _createMemo,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      )
    );
  }
}
