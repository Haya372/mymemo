import 'package:flutter/material.dart';
import 'crud.dart';

class MyListView extends StatefulWidget {
  final int tag;
  MyListView(this.tag);
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  Future<List<Map>> _getData() async {
    Future<List<Map>> res = widget.tag == -1 ? crud.selectAll() : crud.select(widget.tag);
    return res;
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
        List<Map> memos = snapshot.data;
        if(!snapshot.hasData) memos = [];
        return ListView(
          children: [
            for(Map memo in memos)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(memo['title']),
                )
              ),
          ]
        );
      }
    );
  }
}