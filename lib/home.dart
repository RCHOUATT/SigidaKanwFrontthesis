import 'package:flutter/material.dart';
import 'package:sigidakanwmobile/ChoixDesLangues.dart';
import 'package:sigidakanwmobile/CoursParNiveau.dart';
import 'package:sigidakanwmobile/Modal/Utilisateur.dart';
import 'package:sigidakanwmobile/profil.dart';
import 'package:sigidakanwmobile/service/AuthService.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  HomeState createState() => HomeState();

}


class HomeState extends State<Home> {

  final TextEditingController searchUser = TextEditingController();
  late String searchValue;
  dynamic? utilisateur;
  dynamic _selectedLangue;
  dynamic? stat;
  final AuthService _authService = AuthService();
  final CrudServiceWithoutImage Service1 = CrudServiceWithoutImage();

  @override
  void initState() {
    super.initState();
    getStat();
    updateUser();
  }

  Future<void> getStat() async {
    String? token = await _authService.getToken();
    if (token != null) {
      final userId = await _authService.getUserIdFromToken(token);
      final newStat = await Service1.getStat("stat", userId);
      setState(() {
        stat = newStat;
        print(stat);
      });
      print("stat : $stat");
    }
  }

  Future<void> updateUser() async {
    String? token = await _authService.getToken();
    if (token != null) {
      final userId = await _authService.getUserIdFromToken(token);
      final user = await Service1.findUser(userId);
      setState(() {
        utilisateur = user;
        if (utilisateur != null && utilisateur["langues"].isNotEmpty) {
          _selectedLangue = utilisateur["langues"][0];
        }
      });
      //print("Utilisateur1 : ${_selectedLangue["coursList"][0]["typeCours"]["type"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  utilisateur == null
        ? const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 4,
            color: Color(0xFF45A100),
          ),
        )
        : Container(
        color: const Color(0xFFE3EDFD),
        padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 163,
                decoration: BoxDecoration(
                  color: const Color(0xFF85DA47),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: const Color(0xFF5E5E5E)
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profil()));
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            child: CircleAvatar(
                                radius: 50,
                                //backgroundColor: Color(0xFFFFFFFF),
                                child:  ClipOval(
                                  child: Image.asset(
                                    "Assets/Images/profil.png",
                                    fit: BoxFit.cover,
                                  ),
                                )
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: const Text(
                                    "Salut !",
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: "Nunito",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    utilisateur["nom"] ?? "Nom inconnu",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: "Nunito",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: CircleAvatar(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  radius: 50,
                                  child: Image.asset(
                                    "Assets/Icons/bitcoin.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                utilisateur["stats"]["piece"].toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFF3705A)
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        maxLines: 1,
                        controller: searchUser,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          searchValue = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Quelle langue voulez vous apprendre?",
                          suffixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                )
              ),
              const SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: const Color(0xFF5E5E5E)
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Vos langues",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Choixdeslangues()));
                              },
                              child: Image.asset(
                                "Assets/Icons/plus.png",
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                            utilisateur["langues"].map<Widget>((l) {
                              final isSelected = l == _selectedLangue;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedLangue = l;
                                    print(l);
                                    print(isSelected);
                                    print(_selectedLangue);
                                    print(utilisateur);
                                  });
                                },
                                child: Container(
                                  height: 64,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF58CC02) : const Color(0xFFDFDFDF),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFF6B6B6B),
                                        blurStyle: BlurStyle.inner,
                                        blurRadius: 4,
                                        offset: Offset(0, -4),
                                      ),
                                      BoxShadow(
                                        color: Color(0xFF6B6B6B),
                                        blurStyle: BlurStyle.normal,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    l["nom"][0] + l["nom"].substring(1).toLowerCase(),
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      "Assets/Images/band.png",
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: const Color(0xFF5E5E5E)
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x3F6B6B6B),
                        blurStyle: BlurStyle.normal,
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(0, -4)
                    ),
                    BoxShadow(
                      color: Color(0xFF6B6B6B),
                      blurStyle: BlurStyle.normal,
                      blurRadius: 4,
                      spreadRadius: 0,
                    )
                  ]
                ),
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Text("Découvrez nos trésors culturels locaux !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: const Color(0xFF5E5E5E)
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Vos Cours",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Coursparniveau(activeLanguage: _selectedLangue,)));
                              },
                              child: const Text("Voir plus ...",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF85DA47)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _selectedLangue["coursList"]
                              .where((cours) => cours["typeCours"]["type"] == "LINGUISTIQUE") // Filtre les cours de type LINGUISTIQUE
                              .toList() // Convertit le résultat en liste
                              .sublist(0)
                              .map<Widget>((c){
                                return Container(
                                width: 120,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF85DA47),
                                    borderRadius: BorderRadius.circular(10),
                                ),
                                child: LayoutBuilder(
                                  builder: (BuildContext context, BoxConstraints constraints) {
                                    return Column(
                                      children: [
                                        Container(
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Image.network(
                                            c["chapitreList"][0]["contenuList"][0]["files"][0]["url"],
                                            loadingBuilder: (context, child, loadingProgress) {
                                              const SizedBox(
                                                width: double.infinity,
                                                height: 120 * 0.768,
                                                child: Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                              );
                                              if (loadingProgress != null) {
                                                // Affiche le circular indicator pendant le chargement
                                                return const SizedBox(
                                                  width: double.infinity,
                                                  height: 120 * 0.768,
                                                  child: Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                );
                                              }else{return child;}
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(c["titre"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 12
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                )
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
