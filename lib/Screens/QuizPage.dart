import 'package:simpleQuizApplication/Screens/ResultPage.dart';
import 'package:simpleQuizApplication/Service/Question.dart';
import 'package:simpleQuizApplication/Service/QuizManager.dart';
import 'package:simpleQuizApplication/Service/Globals.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}
class _QuizPageState extends State<QuizPage> {
  QuizManager _manager = QuizManager();

  Future<void> quizloader;
  List<Widget> getOptions(Question question) {
    List<Widget> optionButtons = [];
    for (int i = 0; i < question.options.length; i++) {
      optionButtons.add(FlatButton(
        onPressed: () {

          if (_manager.isFinished()) {
            _manager.lastScore(_manager.getCurrentQuestion().options[i].score);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ResultPage(
                      score: _manager.getTotalScore(),
                    )));
          } else {_manager.nextQuestion(_manager.getCurrentQuestion().options[i].score); setState(() {});
          }
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/appBar.png'),
                  fit: BoxFit.fill
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '${_manager.getCurrentQuestion().options[i].text}',
            style: TextStyle(fontFamily: 'TR',color: Colors.black87,
              fontSize: 25,
            ),
          ),
        ),
      ));
    }
    return optionButtons;
  }
  int totalQuestionNumber=Globals.questionNumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizloader = _manager.loadQuestions(totalQuestionNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueGrey,
          title: Row(
            children: [

              Expanded(flex: 5,child: Text(
                'Questions ${_manager.getCurrentId()}/$totalQuestionNumber',textAlign: TextAlign.left,style: TextStyle(fontFamily: 'TR'),),),
              Expanded(flex: 5,child:Text('Score ${_manager.getTotalScore()}',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'TR'),), )
            ],
          ),
        ),
        body: FutureBuilder<void>(
            future: quizloader,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 30,
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Text(
                            '${_manager.getCurrentQuestion().text}',
                            style: TextStyle(fontFamily: 'TR',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20), decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),bottomRight: Radius.circular(50.0)),
                            color: Colors.black54

                        ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: getOptions(_manager.getCurrentQuestion()),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator(backgroundColor: Colors.black54,valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),));
              }
            }));
  }
}
