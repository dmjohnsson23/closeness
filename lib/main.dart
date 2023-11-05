import 'package:closeness/question_set.dart';
import 'package:closeness/questions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Closeness',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: QuestionPage(
        questions: loadQuestions(),
        name1:'Alice', 
        name2:'Bob', 
        color1: ColorScheme.fromSeed(seedColor: Colors.pink), 
        color2: ColorScheme.fromSeed(seedColor: Colors.blue)
        ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.questions, required this.name1, required this.name2, required this.color1, required this.color2});

  final QuestionSet questions;
  final String name1;
  final String name2;
  final ColorScheme color1;
  final ColorScheme color2;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  String? question;
  String? name;
  ColorScheme? color;
  int level = 1;

  void _nextQestion() {
    setState(() {
      if (name == null || name == widget.name2){
        name = widget.name1;
        color = widget.color1;
      }
      else{
        name = widget.name2;
        color = widget.color2;
      }
      question = widget.questions.nextQuestion();
      if (question == null){
        int? nextLevel = widget.questions.nextLevel();
        if (nextLevel == null){
          // Game over
        } else {
          level = nextLevel+1;
          question = widget.questions.nextQuestion();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _nextQestion method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: color?.inversePrimary ?? Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the QuestionPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Level $level'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$question',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '$name goes first',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextQestion,
        tooltip: 'Next Question',
        child: const Icon(Icons.skip_next),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
