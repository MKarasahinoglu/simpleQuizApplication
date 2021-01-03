import 'Question.dart';
import 'Option.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import 'package:simpleQuizApplication/Service/Globals.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizManager {
  QuizManager() {
    //print("before");
    //LoadQuestions(3);
    //  print("after");
  }

  Future<void> loadQuestions(int numberOfQuestions) async {
    var unescape=new HtmlUnescape();
    var url='';
    url='https://opentdb.com/api.php?amount=$numberOfQuestions&category=${Globals.categoryNumber}&difficulty=${Globals.difficultyLevel}&type=${Globals.questionType}';
    print(url);
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
        options.add(Option(unescape.convert(questionJson['correct_answer']), Globals.specifyScore));
        for (int j = 0; j < questionJson['incorrect_answers'].length; j++) {
          options.add(Option(unescape.convert(questionJson['incorrect_answers'][j]), 0));
        }
        Question question = Question(unescape.convert(questionJson['question']), options);
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
  void lastScore(score)
  {
    _score+=score;
    if(_score>100) {_score=100;}
  }
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
    print('getCurrentQuestion $currentQuestionId');
    if (currentQuestionId < _questions.length) {
      return _questions[currentQuestionId];
    } else {
      return Question('', []);
    }
  }
}
