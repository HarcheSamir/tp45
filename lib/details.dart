import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:flutter_tts/flutter_tts.dart';

class NoteDetails extends StatelessWidget {
  final String content;
  final DateTime date;
  final DateFormat formatter = DateFormat('MMM dd, yyyy HH:mm'); // Define date format


  NoteDetails({required this.content, required this.date});
  FlutterTts flutterTts = FlutterTts();

  void speak(String text) async {


    await flutterTts.setLanguage('fr-FR');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);


  }

  void stop() async {
    await flutterTts.stop();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
        backgroundColor: Color(0xFFE1BEE7),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 50, // Adjust as needed
              height: 50, // Adjust as needed
            ),

            SizedBox(height: 16.0),
            Text(
              content,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Created: ${formatter.format(date)}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            ElevatedButton(
              onPressed: () {

                speak(content);
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
      ),
    );
  }
}
