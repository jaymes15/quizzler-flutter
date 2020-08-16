import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


QuizBrain quiz = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scorekeeper = [];

  void showAnswers(bool ans){
    if(scorekeeper.length < quiz.numberofquestions()) {
      if (ans == true) {
        setState(() {
          scorekeeper.add(
              Icon(
                Icons.check,
                color: Colors.green,
              ));
        });
      } else if (ans == false) {
        setState(() {
          scorekeeper.add(
              Icon(
                Icons.close,
                color: Colors.red,
              )
          );
        });
      }
      setState(() {
        quiz.nextQuestion();
      });
    }else{
      _onBasicAlertPressed(context);
      setState(() {
        quiz.resetQuestion();
        scorekeeper.clear();
      });

    }

  }

  _onBasicAlertPressed(context) {
    Alert(
        context: context,
        title: "Quizzler",
        desc: "You Have Gotten To The Last Question.Application Will Be Reset.")
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quiz.getQuestions(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                   var answer = quiz.checkAnswer(true);

                    showAnswers(answer);

                        },
            ),
          )

        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                var answer = quiz.checkAnswer(false);
                showAnswers(answer);

                setState(() {
                  quiz.nextQuestion();
                });
              },
            ),
          ),
        ),
        Row(
        children: scorekeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
