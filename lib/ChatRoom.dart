import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});


  @override
  Widget build(BuildContext context) {

    bool option = false;
    final TextEditingController searchUser = TextEditingController();
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    late String searchValue;
    late bool pass = true;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        width: double.infinity,
        height: hauteur,
        color: const Color(0xFFE3EDFD),
        child: LayoutBuilder(
          builder: (context, constraints){
            double width = constraints.maxWidth;
            double heigth = constraints.maxHeight;
            return
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: width,
                  height: heigth,
                  padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: constraints.maxWidth,
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
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
                                      child: TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Image.asset(
                                          "Assets/Icons/back.png",
                                          color: const Color(0xFF1E90FF),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width1 * 0.67,
                                      child: TextField(
                                        maxLines: 1,
                                        controller: searchUser,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {
                                          searchValue = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "searchValue",
                                          prefixIcon: Icon(Icons.search),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
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
                                    Container(
                                      width: width1 * 0.152,
                                      child: CircleAvatar(
                                        radius: 50,
                                        child: ClipOval(
                                          child: Image.asset(
                                            "Assets/Images/profil.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                            },
                          )
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  //color: Colors.yellow,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 250,
                                          padding: EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF1E90FF),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                                bottomRight: Radius.circular(15),
                                              )
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                                                child: Text(
                                                  "Oui, le chapitre 5 est inclus. Assurez-vous de bien comprendre les concepts clés.",
                                                  selectionColor: Colors.grey[100],
                                                  style: const TextStyle(
                                                    color: Color(0xFFFFFFFF),
                                                    fontSize: 14,
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "12/12/2000",
                                                        selectionColor: Colors.grey[100],
                                                        style: const TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontSize: 13,
                                                          fontFamily: "Nunito",
                                                          fontWeight: FontWeight.w900,
                                                        ),
                                                      ),
                                                      Text(
                                                        "22 : 00",
                                                        selectionColor: Colors.grey[100],
                                                        style: const TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontSize: 13,
                                                          fontFamily: "Nunito",
                                                          fontWeight: FontWeight.w900,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  //color: Colors.yellow,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 250,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                                bottomRight: Radius.circular(15),
                                              )
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                                                child: Text(
                                                  "Oui, le chapitre 5 est inclus. Assurez-vous de bien comprendre les concepts clés.",
                                                  selectionColor: Colors.grey[100],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "12/12/2000",
                                                        selectionColor: Colors.grey[100],
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: "Nunito",
                                                          fontWeight: FontWeight.w900,
                                                        ),
                                                      ),
                                                      Text(
                                                        "22 : 00",
                                                        selectionColor: Colors.grey[100],
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: "Nunito",
                                                          fontWeight: FontWeight.w900,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                      Container(
                          width: constraints.maxWidth,
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
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
                                      width: width1 * 0.67,
                                      child: TextField(
                                        maxLines: 1,
                                        controller: searchUser,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {
                                          searchValue = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Votre message",
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                          floatingLabelAlignment: FloatingLabelAlignment.center,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30.0),
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
                                    Container(
                                      width: width1 * 0.152,
                                      child: TextButton(
                                        onPressed: () {  },
                                        child: const Icon(
                                          color: Color(0xFF1E90FF),
                                          Icons.send,
                                        ),
                                      )
                                    )
                                  ],
                                );
                            },
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
