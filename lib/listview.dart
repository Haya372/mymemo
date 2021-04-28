import 'package:flutter/material.dart';
import 'crud.dart';

class MyListView extends StatefulWidget {
  final int tag;
  MyListView(this.tag);
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<Map> memos = [];

  Future<List<Map>> _getData() async {
    Future<List<Map>> res = widget.tag == -1 ? crud.selectAll() : crud.select(widget.tag);
    return res;
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
        if(snapshot.hasData) memos = snapshot.data;
        return ListView(
          children: [
            for(Map memo in memos)
              ItemWidget(memo),
          ]
        );
      }
    );
  }
}

class ItemWidget extends StatefulWidget {
  final Map memo;
  ItemWidget(this.memo);
  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  void _handleTap() {
    print('tapped');
  }


  void _handleDelete(DismissDirection direction){
    crud.delete(widget.memo["id"]);
  }

  @override
  Widget build(BuildContext context){
    return Dismissible(
      key: ValueKey<int>(widget.memo['id']),
      child: GestureDetector(
        child: ListTile(
            title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(widget.memo['title']),
          )
        ),
        onTap: _handleTap,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: _handleDelete,
      background: Container(
        color: Colors.red,
        child: Row(
          children: [
            Padding(
              child : Icon(Icons.delete, color: Colors.white,),
              padding: EdgeInsets.all(8),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
    );
  }
}