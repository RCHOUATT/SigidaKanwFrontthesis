import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Takeclass extends StatefulWidget {
  const Takeclass(this.chapitre, {super.key});

  final dynamic chapitre;

  @override
  _Takeclass createState() => _Takeclass(chapitre);
}

class _Takeclass extends State<Takeclass> {
  late final dynamic _activechapitre;
  bool start = true;
  int index = -1;
  double progressePercent = 0.0;

  _Takeclass(dynamic chapitre) {
    this._activechapitre = chapitre;
  }

  @override
  void initState() {
    super.initState();
    print(this._activechapitre);
    print(_activechapitre["contenuList"].length);
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  void _toggleAudio(String link) async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause(); // Met l'audio en pause
      } else {
        await _audioPlayer.setUrl(link); // Charge l'audio
        await _audioPlayer.play(); // Joue l'audio
      }
      setState(() {
        _isPlaying = !_isPlaying; // Change l'état de lecture
      });
    } catch (e) {
      print("Erreur de lecture audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFE3EDFD),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (index > 0 && index < _activechapitre["contenuList"].length) {
                              setState(() {
                                index--;
                                progressePercent = index / (_activechapitre["contenuList"].length - 1);
                              });
                            } else if (index == 0) {
                              setState(() {
                                start = true;
                                index--;
                              });
                            } else {
                              Navigator.pop(context);
                            }
                            _audioPlayer.stop(); // Arrête la lecture en cours
                            setState(() {
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progressePercent,
                          color: const Color(0xFF45A100),
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 7,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
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
                              start
                                  ? opening(this._activechapitre["titre"], this._activechapitre["resume"])
                                  : Column(
                                children: [
                                  LayoutBuilder(
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
                                                _activechapitre["contenuList"][index]["titre"][0].toUpperCase() +
                                                    _activechapitre["contenuList"][index]["titre"].substring(1).toLowerCase(),
                                                style: const TextStyle(
                                                  fontFamily: "Lexend",
                                                  fontSize: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
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
                                        child: Text(
                                          _activechapitre["contenuList"][index]["description"][0].toUpperCase() +
                                              _activechapitre["contenuList"][index]["description"].substring(1).toLowerCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily: "Lexend",
                                            fontSize: 18,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
                            onPressed: () {
                              if (index == -1) {
                                setState(() {
                                  start = false;
                                  index++;
                                });
                              } else if (index >= 0 && index < _activechapitre["contenuList"].length - 1) {
                                setState(() {
                                  index++;
                                  progressePercent = index / (_activechapitre["contenuList"].length - 1);
                                });
                              } else if (index == _activechapitre["contenuList"].length - 1) {
                                // Logique pour la fin des chapitres
                              }
                              _audioPlayer.stop(); // Arrête la lecture
                              setState(() {
                                _isPlaying = false;
                              });
                            },
                            child: const Text("Suivant", style: TextStyle(color: Color(0xFFFFFFFF))),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
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
              fontFamily: "Lexend",
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Libère les ressources de l'AudioPlayer
    super.dispose();
  }
}
