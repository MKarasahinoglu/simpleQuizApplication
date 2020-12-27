import 'package:cetquiz_app/Screens/QuizPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void gotoQuizPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => QuizPage()),
  );
}
class HomePage extends StatelessWidget { //ignore: must_be_immutable
  static int optionDecided=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey,title:Text('Bilgisayar Sınavı',style: TextStyle(fontFamily: 'TR'),)),
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
                'Bilgisayar Sınavına Hoşgeldiniz', textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold, fontFamily: 'TR', color: Colors.black54
                ),
              ),

            ),
            SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {
                optionDecided=1;
                gotoQuizPage(context);
              },
              child: Container(width: 150,height: 50,child: Image.asset('assets/button1.png',color: Colors.blueGrey,),),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                optionDecided=2;
                gotoQuizPage(context);
              },
              child: Container(width: 150,height: 50,child: Image.asset('assets/button2.png',color: Colors.blueGrey,),),
            ),
          ],
        ),
      )
    );
  }
}
