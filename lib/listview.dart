import 'package:flutter/material.dart';
import 'crud.dart';
import 'editpage.dart';

class MyListView extends StatefulWidget {
  final int tag;
  MyListView(this.tag);
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  Future<List<Map>> memos;

  @override
  void initState () {
    super.initState();
    memos = widget.tag == -1 ? crud.selectAll() : crud.select(widget.tag);
  }

  void _handleTap(Map memo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return MyEditPage(memo);
      }
    ));
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: memos,
      builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
        List<Map> datas = snapshot.hasData ? snapshot.data : [];
        return ListView(
          children: [
            for(Map memo in datas)
              ItemWidget(memo, _handleTap),
          ]
        );
      }
    );
  }
}

class ItemWidget extends StatefulWidget {
  final Map memo;
  final ValueChanged<Map> onTapped;
  ItemWidget(this.memo, this.onTapped);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  void _handleTap() {
    widget.onTapped(widget.memo);
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