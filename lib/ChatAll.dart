import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'CustomTextField.dart';

class Chatall extends StatelessWidget {
  const Chatall({super.key});


  @override
  Widget build(BuildContext context) {

    bool option = false;
    final TextEditingController searchUser = TextEditingController();
    double largeur = MediaQuery.of(context).size.width;
    late String searchValue;
    late bool pass = true;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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
                        Container(
                            width: double.infinity,
                            height: heigth * 0.89,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/chatRoom");
                                    },
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                        foregroundColor: const Color(0xFF232323),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0),
                                        )
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      child: LayoutBuilder(
                                        builder: (context, constraints){
                                          double width = constraints.maxWidth;
                                          double height = constraints.maxHeight;
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    "Assets/Images/profil.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width : width * 0.28,
                                                child: const Text(
                                                  "@Username",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width : width * 0.3,
                                                child: const Text(
                                                  "@Username",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Color(0xFF1E90FF),
                                                    fontSize: 14,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width : width * 0.3,
                                                child: const Text(
                                                  "12 : 00",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF1E90FF),
                                                    fontSize: 14,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/chatRoom");
                                    },
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                        foregroundColor: const Color(0xFF232323),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0),
                                        )
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      child: LayoutBuilder(
                                        builder: (context, constraints){
                                          double width = constraints.maxWidth;
                                          double height = constraints.maxHeight;
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    "Assets/Images/profil.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width : width * 0.28,
                                                child: const Text(
                                                  "@Username",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width : width * 0.3,
                                                child: const Text(
                                                  "@Username",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Color(0xFF1E90FF),
                                                    fontSize: 14,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width : width * 0.3,
                                                child: const Text(
                                                  "-- : --",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF1E90FF),
                                                    fontSize: 14,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w500,
                                                  ),
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
