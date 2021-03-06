import 'package:flutter/material.dart';
import 'crud.dart';

class MyCreatePage extends StatefulWidget{
  MyCreatePage();
  @override
  _MyCreatePageState createState() => _MyCreatePageState();
}

class _MyCreatePageState extends State<MyCreatePage> {
  String _title = "";
  String _text = "";
  int _tag = 2;


  @override
  void dispose() {
    if(_title.length != 0) crud.insert(title: _title, text: _text, tag: _tag);
    super.dispose();
  }

  void _handleTitle(String e) {
    setState(() {
      _title = e;
    });
  }

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  void _onTagChanged(int value){
    setState(() {
      _tag = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: Column(
          children: <Widget>[
            TextField(
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28
              ),
              onChanged: _handleTitle,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: RadioListTile(
                    value: 0,
                    groupValue: _tag,
                    onChanged: _onTagChanged,
                    title: Text("STUDY", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: RadioListTile(
                    value: 1,
                    groupValue: _tag,
                    onChanged: _onTagChanged,
                    title: Text("SHOP", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: RadioListTile(
                    value: 2,
                    groupValue: _tag,
                    onChanged: _onTagChanged,
                    title: Text("OTHER", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10)
                ),
                onChanged: _handleText,
              ),
            )
          ],
        )
    );
  }
}
