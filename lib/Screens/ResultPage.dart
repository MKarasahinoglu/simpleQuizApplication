import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ResultPage extends StatefulWidget { //ignore: must_be_immutable
  int score;
  ResultPage({Key key, this.score}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String passOrFailText='';
  void passedOrFailed(){
    if(widget.score>=70) {passOrFailText='assets/pass.png'; print('pass');}
    else {passOrFailText='assets/fail.png'; }
  }

  @override
  Widget build(BuildContext context) {
    passedOrFailed();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey,
        title: Text(' Sonuç ',style: TextStyle(fontFamily: 'TR',fontSize:25),),
      ),
      body: Container(alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF373B44),Color(0xAA4286f4)
              ]
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 100, backgroundColor: Colors.white60,
                child: Container(padding: EdgeInsets.all(20),child: Image.asset(passOrFailText),),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tebrikler Puanınız',
              style: TextStyle(fontSize: 30,fontFamily: 'TR',color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${widget.score}',
              style: TextStyle(fontSize: 75, fontWeight: FontWeight.w900,fontFamily: 'TR',color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
