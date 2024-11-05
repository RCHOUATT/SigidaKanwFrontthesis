import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sigidakanwmobile/ApprenantNav.dart';
import 'package:sigidakanwmobile/service/AuthService.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';

import 'Modal/UserProvider.dart';


class Takeclass extends StatefulWidget {

  const Takeclass(this.chapitre, {super.key});

  final dynamic chapitre;

  @override
  _Takeclass createState() => _Takeclass(chapitre);
}

class _Takeclass extends State<Takeclass> {
  late final dynamic _activechapitre;
  bool start = true;
  bool cour = false;
  bool test = false;
  bool debutCours = true;
  bool testFalse = false;
  bool Teststart = false;
  bool testOk = false;
  bool bonneReponse = false;
  int index = -1;
  int indexTest = 0;
  int progressIndex = -1;
  double progressePercent = 0.0;
  String? _selectedResponse;
  bool _isNextClicked = false;
  double nbrePointAlloue = 0;
  double nbrePieceAlloue = 0;
  double nbreReponseCorrecte = 0;
  dynamic? stat;
  final AuthService _authService = AuthService();
  final CrudServiceWithoutImage Service1 = CrudServiceWithoutImage();

  /*Future<void> getStat() async {
    String? token = await _authService.getToken();
    if (token != null) {
      final userId = await _authService.getUserIdFromToken(token);
      final newStat = await Service1.getStat(stat, userId);
      setState(() {
        stat = newStat;
      });
      print("Utilisateur : $stat");
    }
  }
*/
  _Takeclass(dynamic chapitre){
    this._activechapitre = chapitre;
  }

  @override
  void initState() {
    super.initState();
    //getStat();
    print(this._activechapitre);
    print(_activechapitre["contenuList"].length);
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  void _toggleAudio(String link) {
    setState(() {
      _isPlaying = !_isPlaying; // Change l'état de lecture
      if (!_isPlaying) {
        _audioPlayer.pause(); // Met l'audio en pause
      } else {
        print(link);
        _audioPlayer.play(UrlSource(link)); // Joue l'audio
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double largeur = MediaQuery
        .of(context)
        .size
        .width;
    double hauteur = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: debutCours ?
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFE3EDFD),
        child: LayoutBuilder(
          builder: (context, constraints){
            double width = constraints.maxWidth;
            double heigth = constraints.maxHeight;
            return
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 42,
                      child: Row(
                        children: [
                          if(cour || start)
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26, // Color of the shadow
                                      blurRadius: 4.0, // Softness of the shadow
                                      spreadRadius: 1.0, // How much the shadow spreads
                                      offset: Offset(2.0, 2.0), // Position of the shadow (x, y)
                                    ),
                                  ]
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  if(index > 0 && index < _activechapitre["contenuList"].length){
                                    setState(() {
                                      index--;
                                      progressIndex--;
                                      print(index);
                                      print(_activechapitre["testList"]);
                                      progressePercent = progressIndex/((_activechapitre["contenuList"].length - 1) + (_activechapitre["testList"][0]["questionList"].length - 1));
                                    });
                                  }else if(index == 0){
                                    setState(() {
                                      start = true;
                                      index--;
                                      progressIndex--;
                                      print(index);
                                    });
                                  } else{
                                    Navigator.pop(context);
                                  }
                                  setState(() {
                                    _audioPlayer.pause();
                                    _isPlaying = false;
                                  });
                                },
                                child: const Icon(
                                  Icons.chevron_left,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ),
                            ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progressePercent,
                              color: const Color(0xFF45A100),
                              borderRadius: BorderRadius.circular(10),
                              minHeight: 7,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            //color: Color(0xFF45A100),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  start ?
                                  opening(this._activechapitre["titre"], this._activechapitre["resume"]) : cour ?
                                  Column(
                                    children: [
                                      /*LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Container(
                                            width: constraints.maxWidth * 0.7,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  iconSize: 38,
                                                  icon: Icon(_isPlaying ? Icons.pause : Icons.volume_up_rounded),
                                                  onPressed: () {
                                                    if (_activechapitre["contenuList"][index]["files"][1] != null) {
                                                      String audioLink = _activechapitre["contenuList"][index]["files"][1]["url"];
                                                      _toggleAudio(audioLink);
                                                      print(audioLink);
                                                      print(_isPlaying);
                                                    } else {
                                                      print("Aucun fichier audio disponible à cet index.");
                                                    }
                                                  },
                                                ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Text(
                                                    maxLines: 1,
                                                    _activechapitre["contenuList"][index]["titre"][0].toUpperCase() + _activechapitre["contenuList"][index]["titre"].substring(1).toLowerCase(),
                                                    style: const TextStyle(
                                                      fontFamily: "Lexend",
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      ),*/
                                      Text(
                                        maxLines: 1,
                                        _activechapitre["contenuList"][index]["titre"][0].toUpperCase() + _activechapitre["contenuList"][index]["titre"].substring(1).toLowerCase(),
                                        style: const TextStyle(
                                          fontFamily: "Lexend",
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Container(
                                        width: 120,
                                        height: 120,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Image.network(
                                          _activechapitre["contenuList"][index]["files"][0]["url"],
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      LayoutBuilder(
                                          builder: (context, constraint) {
                                            return Container(
                                              width: constraint.maxWidth * 0.7,
                                              //color: Colors.grey,
                                              child: Text(
                                                _activechapitre["contenuList"][index]["description"][0].toUpperCase() + _activechapitre["contenuList"][index]["description"].substring(1).toLowerCase(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: "Lexend",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                          }
                                      ),
                                    ],
                                  ) : Teststart ?
                                  openingQuiz() : test ?
                                  Column(
                                    children: [
                                      /*LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Container(
                                            width: constraints.maxWidth * 0.7,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  iconSize: 38,
                                                  icon: Icon(_isPlaying ? Icons.pause : Icons.volume_up_rounded),
                                                  onPressed: () {
                                                    if (_activechapitre["contenuList"][index]["files"][1] != null) {
                                                      String audioLink = _activechapitre["contenuList"][index]["files"][1]["url"];
                                                      _toggleAudio(audioLink);
                                                      print(audioLink);
                                                      print(_isPlaying);
                                                    } else {
                                                      print("Aucun fichier audio disponible à cet index.");
                                                    }
                                                  },
                                                ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Text(
                                                    maxLines: 1,
                                                    _activechapitre["contenuList"][index]["titre"][0].toUpperCase() + _activechapitre["contenuList"][index]["titre"].substring(1).toLowerCase(),
                                                    style: const TextStyle(
                                                      fontFamily: "Lexend",
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      ),*/
                                      Text(
                                        maxLines: 2,
                                        "Question ${indexTest + 1} : "  + _activechapitre["testList"][0]["questionList"][indexTest]["question"][0].toUpperCase() + _activechapitre["testList"][0]["questionList"][indexTest]["question"].substring(1).toLowerCase(),
                                        style: const TextStyle(
                                          fontFamily: "Lexend",
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Container(
                                        width: 120,
                                        height: 120,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Image.network(
                                          _activechapitre["testList"][0]["questionList"][indexTest]["files"][0]["url"],
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      LayoutBuilder(
                                        builder: (context, constraint) {
                                            return Container(
                                              width: constraint.maxWidth * 0.7,
                                              //color: Colors.grey,
                                              child: Column(
                                                children: _activechapitre["testList"][0]["questionList"][indexTest]["reponsePossibleList"].map<Widget>((reponse) {
                                                  return RadioListTile<String>(
                                                    title: Text(reponse["reponsePossible"]), // Assurez-vous d'utiliser la bonne clé
                                                    value: reponse["reponsePossible"],
                                                    groupValue: _selectedResponse,
                                                    onChanged: _isNextClicked // Désactivez le changement si "Suivant" a été cliqué
                                                        ? null // Si "_isNextClicked" est vrai, ne rien faire
                                                        : (String? value) {
                                                      setState(() {
                                                        _selectedResponse = value; // Met à jour la réponse sélectionnée
                                                        if(!_isNextClicked){
                                                          _isNextClicked = true;
                                                          print(_isNextClicked);
                                                        }
                                                        print("selectedReponse" + _selectedResponse!);
                                                      });
                                                    },
                                                  );
                                                }).toList(),
                                              ),
                                            );
                                          }
                                      ),
                                    ],
                                  ) : Container(),
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                    if(testOk)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: constraints.maxWidth * 0.7,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5FFD8),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Column(
                              children: [
                                bonneReponse ?
                                const Text("C'est exact'", style: TextStyle(color: Color(0xFF45A100)),) :
                                  Column(
                                    children: [
                                      const Text("Oups.. Ce n'est pas correcte.'", style: TextStyle(color: Color(0xEFFF023B)),),
                                      const SizedBox(height: 10,),
                                      Text("Reponse: ${_activechapitre["testList"][0]["questionList"][indexTest]["reponseCorrecte"]}", style: TextStyle(color: Color(0xFFFFF023B)),),
                                    ],
                                  )
                              ],
                            ),
                          );
                        }
                      ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 130,
                            height: 45,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: Color(0xFF45A100),
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: (){
                                  if(index == -1){
                                    setState(() {
                                      start = false;
                                      cour = true;
                                      index++;
                                      progressIndex++;
                                      print(index);
                                      print(progressIndex);
                                    });
                                  }
                                  else if (index >= 0 && index < _activechapitre["contenuList"].length - 1) {
                                    setState(() {
                                      index++;
                                      progressIndex++;
                                      print(_activechapitre["testList"][0]);
                                      print(index);
                                      progressePercent = progressIndex/((_activechapitre["contenuList"].length - 1) + (_activechapitre["testList"][0]["questionList"].length));

                                      print(progressePercent);
                                    });
                                  }else if(index == _activechapitre["contenuList"].length - 1 && cour == true){
                                    setState(() {
                                      cour = false;
                                      Teststart = true;
                                    });
                                  }else if(index == _activechapitre["contenuList"].length - 1 && Teststart == true){
                                    setState(() {
                                      Teststart = false;
                                      test = true;
                                    });
                                  } else if(index == _activechapitre["contenuList"].length - 1 && Teststart == true){
                                    setState(() {
                                      Teststart = false;
                                      test = true;
                                    });
                                  }
                                  else if(indexTest <= _activechapitre["testList"][0]["questionList"].length - 2){
                                    if(!testOk){
                                      setState(() {
                                        testOk = !testOk;
                                        _isNextClicked = true;
                                        if(_selectedResponse == _activechapitre["testList"][0]["questionList"][indexTest]["reponseCorrecte"]){
                                          bonneReponse = true;
                                          nbrePointAlloue = (_activechapitre["testList"][0]["nbrePoint"] / _activechapitre["testList"][0]["questionList"].length) + nbrePointAlloue;
                                          nbreReponseCorrecte++;
                                          print(nbrePointAlloue);
                                        }
                                      });
                                    }
                                    else if(testOk){
                                      setState(() {
                                        testOk = !testOk;
                                        _isNextClicked = false;
                                        _selectedResponse = null;
                                        indexTest++;
                                        progressIndex++;
                                        bonneReponse = false;
                                        print(_activechapitre["testList"][0]);
                                        print(indexTest);
                                        progressePercent = progressIndex/((_activechapitre["contenuList"].length - 1) + (_activechapitre["testList"][0]["questionList"].length));
                                        print(progressePercent);
                                      });
                                  }
                                  }
                                  else if(indexTest <= _activechapitre["testList"][0]["questionList"].length - 1){
                                    if(!testOk){
                                      setState(() {
                                        testOk = !testOk;
                                        if(_selectedResponse == _activechapitre["testList"][0]["questionList"][indexTest]["reponseCorrecte"]){
                                          bonneReponse = true;
                                          nbrePointAlloue = (_activechapitre["testList"][0]["nbrePoint"] / _activechapitre["testList"][0]["questionList"].length) + nbrePointAlloue;
                                          nbreReponseCorrecte++;
                                          print(nbrePointAlloue);
                                        }
                                      });
                                    }
                                    else if(testOk){
                                      setState(() {
                                        testOk = !testOk;
                                        progressIndex++;
                                        bonneReponse = false;
                                        print(_activechapitre["testList"][0]);
                                        print(indexTest);
                                        progressePercent = progressIndex/((_activechapitre["contenuList"].length - 1) + (_activechapitre["testList"][0]["questionList"].length));
                                        nbrePieceAlloue = 10 * (nbreReponseCorrecte/ _activechapitre["testList"][0]["questionList"].length);
                                        debutCours = false;
                                        print(progressePercent);
                                      });
                                  }
                                  };
                                  setState(() {
                                    _audioPlayer.pause();
                                    _isPlaying = false;
                                  });
                                },
                                child: const Text("Suivant", style: TextStyle(color: Color(0xFFFFFFFF)),)
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
          },
        )
      ) :
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFE3EDFD),
          child: LayoutBuilder(
            builder: (context, constraints){
              return
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              //color: Color(0xFF45A100),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              widthFactor: 1,
                              heightFactor: 1,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    checkSucces(nbreReponseCorrecte),
                                  ],
                                ),
                              ),
                            )
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 130,
                              height: 45,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    backgroundColor: Color(0xFF45A100),
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async{
                                    String? token = await _authService.getToken();
                                    if (token != null) {
                                      final userId = await _authService.getUserIdFromToken(token);
                                      final user = await Service1.findUser(userId);
                                      int? reponse = await Service1.modifierStatistiques(user?["stats"]?["id"], nbrePointAlloue.toInt(), nbrePieceAlloue.toInt());
                                      print(reponse);
                                      if (reponse! >= 200 && reponse! <= 205) {
                                        String? token = await _authService.getToken();
                                        final userId = await _authService.getUserIdFromToken(token!);
                                        Provider.of<UserProvider>(context, listen: false).initializeUser(userId); // Remplacez 'user_id' par l'ID réel
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => ApprenantNav()),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text("Terminer", style: TextStyle(color: Color(0xFFFFFFFF)),)
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
            },
          )
      )
    );
  }

  Widget opening(String title, String resume) {
    return Center(
      child: Column(
        children: [
          Text(
            title[0].toUpperCase() + title.substring(1).toLowerCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontFamily: "Lexend"
            ),
          ),
        ],
      ),
    );
  }

  Widget openingQuiz() {
    return Center(
      child: Column(
        children: [
          const Text(
            "Quiz",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xFF000000),
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: "Lexend"
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: 120,
            height: 120,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "Assets/Images/quiz.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Libère les ressources de l'audio player
    super.dispose();
  }

  Widget checkSucces(double nbreReponseCorrecte) {
    return nbreReponseCorrecte >= (_activechapitre["testList"][0]["questionList"].length * 0.6) ?
    Column(
      children: [
        const SizedBox(height: 30),
        Container(
          width: 200,
          height: 200,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            "Assets/Images/felicite.png",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          maxLines: 2,
          "Bravo vous avez réussi !",
          style: const TextStyle(
            fontFamily: "Lexend",
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 30),
        LayoutBuilder(
            builder: (context, constraint) {
              return Wrap(
                runSpacing: constraint.maxWidth * 0.03,
                spacing: constraint.maxWidth * 0.03,
                children: [
                  Container(
                    height: 42,
                    width: constraint.maxWidth * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF45A100),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                        textAlign: TextAlign.center,
                        formatDouble(100 * (nbreReponseCorrecte/_activechapitre["testList"][0]["questionList"].length)) + "%"
                    ),
                  ),
                  Container(
                    height: 42,
                    width: constraint.maxWidth * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF45A100),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          formatDouble(nbrePointAlloue),
                        ),
                        Image.asset(
                          "Assets/Icons/star.png",
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 42,
                    width: constraint.maxWidth * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF45A100),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          formatDouble(nbrePieceAlloue),
                        ),
                        Image.asset(
                          "Assets/Icons/bitcoin.png",
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
        ),
      ],
    ) :
    Column(
      children: [
        const SizedBox(height: 30),
        Container(
          width: 200,
          height: 200,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            "Assets/Images/echecs.png",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          maxLines: 2,
          "Oups, On apprend à chaque essai.",
          style: const TextStyle(
            fontFamily: "Lexend",
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 30),
        LayoutBuilder(
            builder: (context, constraint) {
              return Wrap(
                runSpacing: constraint.maxWidth * 0.03,
                spacing: constraint.maxWidth * 0.03,
                children: [
                  Container(
                    height: 42,
                    width: constraint.maxWidth * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xEFFF023B),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                        textAlign: TextAlign.center,
                        "${100 * (nbreReponseCorrecte/_activechapitre["testList"][0]["questionList"].length)}%"
                    ),
                  ),
                  Container(
                    height: 42,
                    width: constraint.maxWidth * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xEFFF023B),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          formatDouble(nbrePointAlloue),
                        ),
                        Image.asset(
                          "Assets/Icons/star.png",

                        )
                      ],
                    ),

                  ),
                  Container(
                    height: 42,
                    width: constraint.maxWidth * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xEFFF023B),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            textAlign: TextAlign.center,
                            formatDouble(nbrePieceAlloue),
                        ),
                        Image.asset(
                          "Assets/Icons/bitcoin.png",
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
        ),
      ],
    );
  }

  String formatDouble(double value) {
    // Crée une instance de NumberFormat pour formater à 2 décimales
    final NumberFormat formatter = NumberFormat('##0');
    return formatter.format(value); // Formate la valeur
  }
}

