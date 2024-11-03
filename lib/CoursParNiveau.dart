import 'package:flutter/material.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';
import 'package:sigidakanwmobile/takeClass.dart';

class Coursparniveau extends StatefulWidget {
  @override
  _CourCoursparniveauState createState() => _CourCoursparniveauState();
}

class _CourCoursparniveauState extends State<Coursparniveau> {
  List<dynamic> Cours = [];
  dynamic utilisateur;
  List<dynamic> niveau = <dynamic>[]; // Type modifié en List<dynamic>?

  final CrudServiceWithoutImage _serviceWithoutImage = CrudServiceWithoutImage();

  @override
  void initState() {
    super.initState();
    updateNiveau();
  }

  Future<void> updateNiveau() async {
    final level = _serviceWithoutImage.getdata("niveauEtudes");
    final stream = _serviceWithoutImage.getdata("niveauEtudes");
    stream.listen((data) {
      setState(() {
        // Transformez chaque élément en GenreUser
        niveau = data;
      });
    });
    print("niveau : $niveau");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: niveau == null
          ? const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 4,
          color: Color(0xFF45A100),
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFE3EDFD),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                child: Column(
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
                                  color: Colors.black26, // Color of the shadow
                                  blurRadius: 4.0, // Softness of the shadow
                                  spreadRadius: 1.0, // How much the shadow spreads
                                  offset: Offset(2.0, 2.0), // Position of the shadow (x, y)
                                ),
                              ]
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: niveau.map<Widget>((n) {
                        return Column(
                          children: [
                            Container(
                              width: constraints.maxWidth,
                              height: 60,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 13),
                              decoration: BoxDecoration(
                                color: const Color(0xFF58CC02),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  n["niveau"][0].toUpperCase() +
                                      n["niveau"].substring(1).toLowerCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "Lexend",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: n["CoursList"].map<Widget>((c) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: width * 0.3,
                                              child: Text(
                                                c["titre"][0].toUpperCase() +
                                                    c["titre"].substring(1).toLowerCase(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: 14,
                                                  fontFamily: 'Lexend',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: c["chapitreList"].map<Widget>((ch) {
                                          return SizedBox(
                                            width: (width * 0.5) - 6,
                                            height: 52,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Takeclass(ch)));
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
                                              child: Text(
                                                ch["titre"][0].toUpperCase() +
                                                    ch["titre"].substring(1).toLowerCase(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Lexend",
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
