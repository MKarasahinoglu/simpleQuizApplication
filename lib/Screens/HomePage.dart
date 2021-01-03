import 'package:simpleQuizApplication/Screens/QuizPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simpleQuizApplication/Service/Globals.dart';
void gotoQuizPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => QuizPage()),
  );
}
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();
}
class _HomePageState extends State<HomePage> { //ignore: must_be_immutable
  String _category='Books';
  String _questionNumber='5';
  String _difficulty='Easy';
  String _questionType='Multiple Choice';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey,title:Text('Computer Test',style: TextStyle(fontFamily: 'TR'),)),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/defaultPage.png'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 700, height: 80, alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/appBar.png',),
                    fit: BoxFit.fill
                  )
              ),
              child: Text(
                'Welcome to Computer Test', textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold, fontFamily: 'TR', color: Colors.black54
                ),
              ),

            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              value: _category,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _category = newValue;
                });
              },
              items: <String>['Books', 'Films', 'Musics', 'Video Games', 'Mythology']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _questionNumber,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _questionNumber = newValue;
                });
              },
              items: <String>['5', '10', '15', '20', '25']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _difficulty,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _difficulty = newValue;
                });
              },
              items: <String>['Easy', 'Medium', 'Hard']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _questionType,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _questionType = newValue;
                });
              },
              items: <String>['Multiple Choice', 'True-False']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                switch(_category)
                {
                  case 'Books': {Globals.categoryNumber=10;} break;
                  case 'Films': {Globals.categoryNumber=11;} break;
                  case 'Musics': {Globals.categoryNumber=12;} break;
                  case 'Video Games': {Globals.categoryNumber=15;} break;
                  case 'Mythology': {Globals.categoryNumber=20;} break;
                }
                switch(_questionNumber)
                {
                  case '5':{Globals.questionNumber=5; Globals.specifyScore=20;} break;
                  case '10':{Globals.questionNumber=10; Globals.specifyScore=10;} break;
                  case '15':{Globals.questionNumber=15; Globals.specifyScore=7;} break;
                  case '20':{Globals.questionNumber=20; Globals.specifyScore=5;} break;
                  case '25':{Globals.questionNumber=25; Globals.specifyScore=4;} break;
                }
                switch(_difficulty)
                {
                  case 'Easy':{Globals.difficultyLevel='easy';} break;
                  case 'Medium':{Globals.difficultyLevel='medium';} break;
                  case 'Hard':{Globals.difficultyLevel='hard';} break;
                }
                switch(_questionType)
                {
                  case 'Multiple Choice':{Globals.questionType='multiple';} break;
                  case 'True-False':{Globals.questionType='boolean';} break;
                }
                print(Globals.categoryNumber);
                gotoQuizPage(context);
              },
              child: Container(width: 150,height: 50,child: Image.asset('assets/button1.png',color: Colors.blueGrey,),),
            ),
          ],
        ),
      )
    );
  }
}
