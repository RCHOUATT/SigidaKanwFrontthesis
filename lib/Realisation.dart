import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'CustomTextField.dart';

class Realisation extends StatelessWidget {
  const Realisation({super.key});


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
                                color: Color(0xFF58CC02),
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
                                            "Niveaux",
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
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.pushNamed(context, "/chatRoom");
                                    },
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                        backgroundColor: Color(0xFFFFFFFF),
                                        foregroundColor: const Color(0xFF232323),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        )
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      //margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        //color: Color(0xFFFFFFFF),
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
                                                  "Débutant",
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
                                              Container(
                                                width : 14,
                                                //color: Colors.white,
                                                child: Image.asset(
                                                  "Assets/Icons/right-arrow.png",
                                                  color: Color(0xFF000000),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.pushNamed(context, "/chatRoom");
                                    },
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                        backgroundColor: Color(0xFFFFFFFF),
                                        foregroundColor: const Color(0xFF232323),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        )
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      //margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        //color: Color(0xFFFFFFFF),
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
                                                  "Intermediaire",
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
                                              Container(
                                                width : 14,
                                                //color: Colors.white,
                                                child: Image.asset(
                                                  "Assets/Icons/right-arrow.png",
                                                  color: Color(0xFF000000),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.pushNamed(context, "/chatRoom");
                                    },
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                        backgroundColor: Color(0xFFDFDFDF),
                                        foregroundColor: const Color(0xFF232323),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        )
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      //margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        //color: Color(0xFFDFDFDF),
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
                                                width : 24,
                                                height: 24,
                                                //color: Colors.white,
                                                child: Image.asset(
                                                  "Assets/Icons/lock.png",
                                                  color: const Color(0xFF9BD570),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Container(
                                                  child: const Text(
                                                    "Avance",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Color(0xFF404040),
                                                      fontSize: 14,
                                                      fontFamily: 'Lexend',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width : 14,
                                                //color: Colors.white,
                                                child: Image.asset(
                                                  "Assets/Icons/right-arrow.png",
                                                  color: Color(0xFF404040),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
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
