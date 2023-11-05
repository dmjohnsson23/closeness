import 'dart:math';

class QuestionSet{
  QuestionSet({required this.questions});

  int currentLevel = 0;
  final List<List<String>> questions;
  List<Set<int>> visited = [{}];
  final Random random = Random();

  int? nextLevel(){
    if (currentLevel < questions.length + 1){
      currentLevel ++;
      visited.add({});
      return currentLevel;
    }
    return null;
  }

  String? nextQuestion(){
    Set<int> available = Set.of(List<int>.generate(questions[currentLevel].length, (i) => i));
    available.removeAll(visited[currentLevel]);
    int chosen;
    if (available.isEmpty) {
      return null;
    } else if (available.length == 1) {
      chosen = available.first;
    } else {
      chosen = available.elementAt(random.nextInt(available.length));
    }
    visited[currentLevel].add(chosen);
    return questions[currentLevel][chosen];
  }
}