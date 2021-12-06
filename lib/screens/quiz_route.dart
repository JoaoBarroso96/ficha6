import 'package:ficha1/models/question.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class QuizRoute extends StatefulWidget {
  @override
  _QuizRoute createState() => new _QuizRoute();
}

class _QuizRoute extends State<QuizRoute> {
  var currentQuestion = 0;

  List<Question> questions = [
    Question("Qual o primeiro Rei de Portugal", "Cristiano Ronaldo",
        "D. Afonso Henriques", "Marcelo", 1),
    Question("Planeta mais próximo ao Sol", "Mercúrio", "Marte", "Terra", 0),
  ];

  Color correctColor = Colors.green;
  Color wrongColor = Colors.red;
  Color defaultColor = Color(0xFF0E3311).withOpacity(0.5);

  List<Color> containerColors = [
    Color(0xFF0E3311).withOpacity(0.5),
    Color(0xFF0E3311).withOpacity(0.5),
    Color(0xFF0E3311).withOpacity(0.5)
  ];

  String _optionSelected = "";

  bool isEnable = true;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 3, //                   <--- border width here
                  ),
                ),
                child: Center(
                    child: Text(questions[currentQuestion].pergunta,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25))),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.1,
                      MediaQuery.of(context).size.height * 0.02,
                      MediaQuery.of(context).size.width * 0.1,
                      MediaQuery.of(context).size.height * 0.02),
                  decoration: BoxDecoration(
                    color: containerColors[0],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    child: RadioButton(
                      description: questions[currentQuestion].res1,
                      value: "0",
                      groupValue: _optionSelected,
                      onChanged: (value) => setState(
                        () => _optionSelected = value.toString(),
                      ),
                      activeColor: Colors.blue,
                    ),
                  )),
              Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.1,
                      MediaQuery.of(context).size.height * 0.02,
                      MediaQuery.of(context).size.width * 0.1,
                      MediaQuery.of(context).size.height * 0.02),
                  decoration: BoxDecoration(
                    color: containerColors[1],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    child: RadioButton(
                      description: questions[currentQuestion].res2,
                      value: "1",
                      groupValue: _optionSelected,
                      onChanged: (value) => setState(
                        () => _optionSelected = value.toString(),
                      ),
                      activeColor: Colors.blue,
                    ),
                  )),
              Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.1,
                      MediaQuery.of(context).size.height * 0.02,
                      MediaQuery.of(context).size.width * 0.1,
                      MediaQuery.of(context).size.height * 0.02),
                  decoration: BoxDecoration(
                    color: containerColors[2],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    child: RadioButton(
                      description: questions[currentQuestion].res3,
                      value: "2",
                      groupValue: _optionSelected,
                      onChanged: (value) => setState(
                        () => _optionSelected = value.toString(),
                      ),
                      activeColor: Colors.blue,
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                        MediaQuery.of(context).size.height * 0.10),
                    primary: Colors.white),
                onPressed: isEnable ? _submitAnswer : null,
                child: const Text("Submeter",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  _submitAnswer() {
    setState(() {
      //Errou a resposta
      if (_optionSelected != questions[currentQuestion].resCerta.toString()) {
        containerColors[int.parse(_optionSelected)] = wrongColor;
      }

      containerColors[questions[currentQuestion].resCerta] = correctColor;

      //Bloquear o botão para impedir que selecione multiplas vezes
      isEnable = false;
    });

    //Esperar 3 segundos para passar para a proxima pergunta
    var future = new Future.delayed(
        const Duration(milliseconds: 3000), callNextQuestion);
  }

  callNextQuestion() {
    setState(() {
      // Verificar se ainda existem mais perguntas
      if (currentQuestion < questions.length - 1) {
        //Incrementar perguntar
        currentQuestion++;
      }

      //Desbloquear o botão
      isEnable = true;

      //Colocar os containers todos com a cor default
      for (int i = 0; i < containerColors.length; i++) {
        containerColors[i] = defaultColor;
      }
    });
  }
}
