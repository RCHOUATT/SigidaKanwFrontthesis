import 'package:flutter/material.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';

class CoursCulturel extends StatefulWidget {
  @override
  _CoursCulturel createState() => _CoursCulturel();
}

class _CoursCulturel extends State<CoursCulturel> {

  List Cours = [];

  final CrudServiceWithoutImage _serviceWithoutImage = new CrudServiceWithoutImage();

  @override
  void initState() {
    super.initState();
    _serviceWithoutImage.getdata("niveauEtudes");
  }

  @override
  Widget build(BuildContext context) {

    bool option = false;
    final TextEditingController searchUser = TextEditingController();
    double largeur = MediaQuery.of(context).size.width;
    late String searchValue;
    late bool pass = true;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFE3EDFD),
          child: LayoutBuilder(
            builder: (context, constraints){
              double width = constraints.maxWidth;
              double heigth = constraints.maxHeight;
              return
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: constraints.maxWidth,
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                            margin: const EdgeInsets.fromLTRB(0,0,0,13),
                            decoration: BoxDecoration(
                                color: const Color(0xFF58CC02),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints){
                                double width1 = constraints.maxWidth;
                                double heigth1 = constraints.maxHeight;
                                return
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width1 * 0.127,
                                        //color: Colors.green,
                                        child: TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Image.asset(
                                            "Assets/Icons/back.png",
                                            color: const Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          //color: Colors.blue,
                                          child: const Text(
                                            "Debutant",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontFamily: "Lexend",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                              },
                            )
                        ),
                        Container(
                        width: double.infinity,
                        height: heigth * 0.89,
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             StreamBuilder(
                                  stream: _serviceWithoutImage.getdata("niveauEtudes"),
                                  builder: (context, snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return const CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        strokeWidth: 4,
                                        color: Color(0xFF0E90FF),
                                      );
                                    };
                                    if(snapshot.hasError){
                                      return Center(child: Text("Erreur ${snapshot.error}"));
                                    };
                                    final cours = snapshot.data!;
                                    print("cours : " + "$cours" );
                                    return
                                      Column(
                                        children: cours.map((c){
                                          return
                                            Container(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    //margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                    height: 50,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFFFFFFF),
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: LayoutBuilder(
                                                      builder: (context, constraints){
                                                        double width = constraints.maxWidth;
                                                        double height = constraints.maxHeight;
                                                        return Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              width : width * 0.3,
                                                              child: const Text(
                                                                "Cours 1 : ................",
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                  color: Color(0xFF000000),
                                                                  fontSize: 14,
                                                                  fontFamily: 'Lexend',
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Wrap(
                                                    direction: Axis.horizontal,
                                                    spacing: 10,
                                                    runSpacing: 10,
                                                    children: [
                                                      SizedBox(
                                                        width: (width * 0.5) - 6,
                                                        height: 52,
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const Level()));
                                                            // Appel du service d'authentification;
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            elevation: 5,
                                                            backgroundColor: Color(0xFFFFFFFF),
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 18, vertical: 7),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Langues",
                                                            style: TextStyle(
                                                              color: Color(0xFF000000),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: "Lexend",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: (width * 0.5) - 6,
                                                        height: 52,
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const Level()));
                                                            // Appel du service d'authentification;
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            elevation: 5,
                                                            backgroundColor: Color(0xFFFFFFFF),
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: 18, vertical: 7),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Culrures",
                                                            style: TextStyle(
                                                              color: Color(0xFF000000),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: "Lexend",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: (width * 0.5) - 6,
                                                        height: 52,
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const Level()));
                                                            // Appel du service d'authentification;
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            elevation: 5,
                                                            backgroundColor: Color(0xFFFFFFFF),
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: 18, vertical: 7),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Culrures",
                                                            style: TextStyle(
                                                              color: Color(0xFF000000),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: "Lexend",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: (width * 0.5) - 6,
                                                        height: 52,
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const Level()));
                                                            // Appel du service d'authentification;
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            elevation: 5,
                                                            backgroundColor: Color(0xFFFFFFFF),
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: 18, vertical: 7),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Culrures",
                                                            style: TextStyle(
                                                              color: Color(0xFF000000),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: "Lexend",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                ],
                                              ),
                                            );
                                        }).toList(),
                                      );
                                  }
                              ),
                            ],
                          ),
                        )
                      ),
                      ],
                    ),
                  ),
                );
            },
          )
      ),
    );
  }

}
