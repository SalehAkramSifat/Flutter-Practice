import 'package:flutter/material.dart';
import 'package:flutter_practice/back_end/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _InputText = TextEditingController();
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _InputText.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    try {
      final data = await DatabaseHelper.instance.getNotes();
      print('Loaded Notes: $data');
      setState(() {
        notes = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      print("Error loading notes: $e");
    }
  }

  Future<void> _saveNote() async {
    try {
      if (_InputText.text.isEmpty) return;

      await DatabaseHelper.instance.insertNote(_InputText.text);
      print('Note Saved: ${_InputText.text}');
      _InputText.clear();
      await _loadNotes();
    } catch (e) {
      print("Error saving note: $e");
    }
  }


  Future<void> _deleteNote(int id) async {
    try {
      await DatabaseHelper.instance.deleteNote(id);
      print('Note Deleted: $id');
      await _loadNotes();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite Database"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _InputText,
              decoration: InputDecoration(
                labelText: "Enter Your Text",
                border: OutlineInputBorder(),
              ),
              minLines: 1,
              maxLines: 3,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _saveNote,
                style: TextButton.styleFrom(backgroundColor: Colors.black),
                child: Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: notes.isEmpty
                  ? Center(child: Text('No Notes Available'))
                  : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        notes[index]['content'],
                        maxLines: 3,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline,
                            color: Colors.deepPurpleAccent),
                        onPressed: () =>
                            _deleteNote(notes[index]['id']),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
