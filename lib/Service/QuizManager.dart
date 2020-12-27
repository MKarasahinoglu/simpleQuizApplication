import 'Question.dart';
import 'Option.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import 'package:cetquiz_app/Screens/HomePage.dart';

class QuizManager {
  QuizManager() {
    //print("before");
    //LoadQuestions(3);
    //  print("after");
  }

  Future<void> loadQuestions(int numberOfQuestions) async {
    var url='';
    if(HomePage.optionDecided==1){url =
        'https://opentdb.com/api.php?amount=$numberOfQuestions&category=18&difficulty=easy&type=multiple';}
    else if(HomePage.optionDecided==2) {url='https://opentdb.com/api.php?amount=$numberOfQuestions&category=18&difficulty=easy&type=boolean';}

    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      //print(response.body);
      Map<String, dynamic> json = converter.jsonDecode(response.body);
      //print(json['response_code']);
      //print(json['results'][0]['question']);
      //print(json['results'][1]['question']);
      //print(json['results'][2]['question']);
      //for (var question in json['results']) {
      //  print(question['question']);
      //  print(question['correct_answer']);
      //  print(question['incorrect_answers']);
      //}
      for (int i = 0; i < json['results'].length; i++) {
        var questionJson = json['results'][i];
        print(questionJson['question']);
        print(questionJson['correct_answer']);
        print(questionJson['incorrect_answers']);
        List<Option> options = [];
        options.add(Option(questionJson['correct_answer'], 10));
        for (int j = 0; j < questionJson['incorrect_answers'].length; j++) {
          options.add(Option(questionJson['incorrect_answers'][j], 0));
        }
        Question question = Question(questionJson['question'], options);
        _questions.add(question);
      }

      _questions.shuffle();
      for (var question in _questions) {
        question.options.shuffle();
      }
    }
  }

  List<Question> _questions = [];
  int _score = 0;
  int currentQuestionId = 0;
  void nextQuestion(score) {
    if (currentQuestionId < _questions.length) {
      _score += score;
      currentQuestionId++;
    }
    print(currentQuestionId);
  }

  int getTotalScore() => _score;
  int getCurrentId() => currentQuestionId+1;

  bool isFinished() {
    return currentQuestionId+1 == _questions.length;
    /* if(currentQuestionId >= _questions.length -1) {
      return true;
    } else {
      return false;
    }
    */
  }

  Question getCurrentQuestion() {
    print('getCurrentQueestion $currentQuestionId');
    if (currentQuestionId < _questions.length) {
      return _questions[currentQuestionId];
    } else {
      return Question('', []);
    }
  }
}
