import 'package:closeness/question_page.dart';
import 'package:closeness/questions.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final name1Controller = TextEditingController();
  final name2Controller = TextEditingController();
  final color1Controller = TextEditingController();
  final color2Controller = TextEditingController();
  Color color1 = Colors.pink;
  Color color2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ColorLabel>> colorEntries =
        <DropdownMenuEntry<ColorLabel>>[];
    for (final ColorLabel color in ColorLabel.values) {
      colorEntries.add(
        DropdownMenuEntry<ColorLabel>(value: color, label: color.label),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Closeness-Generating Proceedure'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: <Widget>[
                DropdownMenu<ColorLabel>(
                  initialSelection: ColorLabel.pink,
                  controller: color1Controller,
                  label: const Text('Color'),
                  width: 100,
                  dropdownMenuEntries: colorEntries,
                  onSelected: (ColorLabel? color) {
                    setState(() {
                      if (color != null){
                        color1 = color.color;
                      }
                    });
                  },
                ),
                Expanded(child: TextFormField(
                  controller: name1Controller,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Person 1 name',
                    icon: const Icon(Icons.person),
                    iconColor: color1,
                  ),
                )),
              ]),
              Row(children: <Widget>[
                DropdownMenu<ColorLabel>(
                  initialSelection: ColorLabel.blue,
                  controller: color2Controller,
                  label: const Text('Color'),
                  width: 100,
                  dropdownMenuEntries: colorEntries,
                  onSelected: (ColorLabel? color) {
                    setState(() {
                      if (color != null){
                        color2 = color.color;
                      }
                    });
                  },
                ),
                Expanded(child: TextFormField(
                  controller: name2Controller,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Person 2 name',
                    icon: const Icon(Icons.person),
                    iconColor: color2,
                  ),
                )),
              ]),
              const Spacer(),
              MaterialButton(
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionPage(
                        questions: loadQuestions(),
                        name1: name1Controller.text,
                        name2: name2Controller.text,
                        color1: ColorScheme.fromSeed(seedColor: color1),
                        color2: ColorScheme.fromSeed(seedColor: color2),
                      )),
                    );
                },
                minWidth: 200,
                height: 65,
                color: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


enum ColorLabel {
  pink('Pink', Colors.pink),
  red('Red', Colors.red),
  orange('Orange', Colors.orange),
  yellow('Yellow', Colors.yellow),
  green('Green', Colors.green),
  cyan('Cyan', Colors.cyan),
  blue('Blue', Colors.blue),
  indigo('Indigo', Colors.indigo),
  purple('Purple', Colors.purple);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

