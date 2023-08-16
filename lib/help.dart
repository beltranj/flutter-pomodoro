import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Barra superior de titulo y menú
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          toolbarHeight: 75,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          title: Text("Help"),
          centerTitle: true,
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'If you have any questions or need assistance, please refer to the following information:',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '1. Timer Settings:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 5),
                Text(
                  'Adjust the Pomodoro timer settings to fit your preferred work and rest intervals. You can choose from different preset durations.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '2. Using the Timer:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 5),
                Text(
                  'Press the play button to start the Pomodoro timer. It will switch between work and rest intervals automatically. You can pause the timer at any time.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '3. Task Management:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 5),
                Text(
                  'The "Tasks" button allows you to manage your tasks and to-do items. You can organize your tasks, mark them as completed, and delete them.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  '4. Need Further Assistance?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10),
                FilledButton.tonal(
                  onPressed: () => launchUrl(Uri.parse(
                      'https://en.wikipedia.org/wiki/Pomodoro_Technique')),
                  child: Text("Learn more about Pomodoro"),
                )
              ],
            ),
          ),
        ));
  }
}
