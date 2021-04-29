import 'package:flutter/material.dart';
import 'crud.dart';

class MyEditPage extends StatefulWidget{
  final Map memo;
  final int parentTag;
  final ValueChanged<int> updateMemos;
  MyEditPage(this.memo, this.parentTag, this.updateMemos);
  @override
  _MyEditPageState createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {
  int _tag;
  TextEditingController _titleController;
  TextEditingController _textController;

  @override
void initState() {
  super.initState();

  _titleController = TextEditingController(text: widget.memo["title"]);
  _textController = TextEditingController(text: widget.memo["text"]);
}

  void _onTagChanged(int value){
    setState(() {
      _tag = value;
    });
  }

  @override
  void dispose() {
    String title = _titleController.text;
    String text = _textController.text;
    crud.update(id: widget.memo["id"], title: title, text: text, tag: _tag).then((value) => {
      widget.updateMemos(widget.parentTag)
    });
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_tag == null) _tag = widget.memo["tag"];
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
              controller: _titleController,
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
                controller: _textController,
              ),
            )
          ],
        )
    );
  }
}
