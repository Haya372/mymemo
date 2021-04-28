import 'package:flutter/material.dart';
import 'crud.dart';
import 'listview.dart';
import 'createpage.dart';

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
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RouteAware {

  void _createMemo() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return MyCreatePage();
      }
    ));
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
                text: "OTHER"
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MyListView(-1),
            MyListView(0),
            MyListView(1),
            MyListView(2)
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
