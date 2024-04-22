import 'package:flutter/material.dart';
import 'package:tp45/details.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> _notes = [];
  Note? _selectedNote ;
  @override
  void initState() {
    super.initState();
  }
  FlutterTts flutterTts = FlutterTts();

  void speak(String text) async {


    await flutterTts.setLanguage('fr-FR');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);


  }

  void stop() async {
    await flutterTts.stop();

  }



  void _addNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String noteContent = '';

        return AlertDialog(

          title: Text('Add Note'),
          content: TextField(
            onChanged: (value) {
              noteContent = value;
            },
            decoration: InputDecoration(hintText: 'Enter your note'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _notes.add(Note(
                    content: noteContent,
                    date: DateTime.now(),
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _viewNoteDetails(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetails(
          content: note.content,
          date: note.date,
        ),
      ),
    );
  }


  void _viewNoteDetails2(Note note) {
    setState(() {
      _selectedNote = note;
    });
  }

  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _notes.removeAt(index);
                  _selectedNote=null;
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: Color(0xFFE1BEE7),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildNoteList2(),
                ),
                Expanded(
                  flex: 1,
                  child: _buildNoteDetails(),
                ),
              ],
            );
          } else {
            return _buildNoteList();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteList() {
    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _viewNoteDetails(_notes[index]),
          onLongPress: () => _confirmDelete(context, index),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: Image.asset(
                    'assets/images/logo.png',
                    width: 50, // Adjust as needed
                    height: 50, // Adjust as needed
                  ),

                  title: Text(
                    'HARCHE Samir',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    _notes[index].content,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[400]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoteList2() {
    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _viewNoteDetails2(_notes[index]),
          onLongPress: () => _confirmDelete(context, index),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: Image.asset(
                    'assets/images/logo.png',
                    width: 50, // Adjust as needed
                    height: 50, // Adjust as needed
                  ),
                  title: Text(
                    'HARCHE Samir',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    _notes[index].content,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Divider(color: Colors.grey[400]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoteDetails() {
    final DateFormat formatter = DateFormat('MMM dd, yyyy HH:mm'); // Define date format
    return Container(
      padding: EdgeInsets.all(16.0),
      child: _selectedNote == null
          ? Center(child: Text('No note selected'))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 50, // Adjust as needed
                  height: 50, // Adjust as needed
                ),

                SizedBox(height: 16.0),
                Text(
                  _selectedNote!.content,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Created: ${formatter.format(_selectedNote!.date)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {

                      speak(_selectedNote!.content);
                      // speak("bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ");

                  },
                  child: Text('Read Aloud'),
                ),
                ElevatedButton(
                  onPressed: () {
                    stop();
                  },
                  child: Text('stop'),
                ),
              ],
            ),

    );
  }



}

class Note {
  String content;
  DateTime date;

  Note({
    required this.content,
    required this.date,
  });
}