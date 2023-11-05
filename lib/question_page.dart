import 'package:closeness/question_set.dart';
import 'package:flutter/material.dart';

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

  late String? question =  widget.questions.nextQuestion();
  late String name = widget.name1;
  late ColorScheme color = widget.color1;
  int level = 1;

  void _nextQestion() {
    setState(() {
      if (name == widget.name2){
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
          Navigator.pop(context);
        } else {
          level = nextLevel+1;
          question = widget.questions.nextQuestion();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.inversePrimary,
        title: Text('Level $level'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextQestion,
        tooltip: 'Next Question',
        backgroundColor: color.inversePrimary,
        child: const Icon(Icons.skip_next),
      ),
    );
  }
}