import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigidakanwmobile/Modal/Utilisateur.dart';
import 'package:sigidakanwmobile/service/CrudServiceWithoutImage.dart';

import 'CustomTextField.dart';
import 'Login.dart';
import 'Modal/GenreUser.dart';
import 'Modal/Pays.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isEmailValid = true; // Pour le statut de validation
  int _index = 0;
  List<GenreUser> _genreUser = <GenreUser>[];
  List<Pays> _pays = <Pays>[];
  Utilisateur newuser = new Utilisateur(
      nom: '',
      email: '',
      pays: null,
      dateBirthday: DateFormat("dd-MM-yyyy").parse("31-12-1970"),
      adresse: '',
      password: '',
      genreUser: null
  );

  bool pass = true; // Correction: pas besoin de 'late' ici
  bool pass1 = true; // Correction: pas besoin de 'late' ici
  String email = '';
  String nom = '';
  DateTime birthDay = DateTime.now();
  String nationnalite = '';
  String firstpassword = '';
  String password = '';
  String secondpassword = '';
  final CrudServiceWithoutImage service = CrudServiceWithoutImage();
  final TextEditingController nationnaliteController = TextEditingController();
  final TextEditingController GenreController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmerpasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGenre();
    _loadPays();
  }

  // Fonction de validation de l'e-mail
  bool _validateEmail(String email) {
    // Expression régulière pour vérifier un e-mail valide
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }
  // Méthode pour charger les genres
  void _loadGenre() {
    final stream = service.getdata("genre");
    stream.listen((data) {
      setState(() {
        // Transformez chaque élément en GenreUser
        _genreUser = data.map<GenreUser>((item) => GenreUser.fromJson(item)).toList();
        print(_genreUser);

        // Si la liste de genres n'est pas vide et que newuser.genreUser n'est pas valide,
        // définissez un genre par défaut (par exemple, le premier de la liste)
        if (_genreUser.isNotEmpty &&
            !_genreUser.any((genre) => genre.id == newuser.genreUser?.id)) {
          newuser.genreUser = _genreUser[0]; // Par défaut, le premier genre
        }
      });
    });
  }

  void _loadPays() {
    // Obtenez les données sous forme de liste
    final stream = service.getdata("pays");
    stream.listen((data) {
      // Transformez chaque élément en Pays
      setState(() {
        print(data);
        _pays = data.map((item) => Pays.fromJson(item)).toList();
        print(_pays);
        if (_pays.isNotEmpty &&
            !_pays.any((pays) => pays.id == newuser.pays?.id)) {
          newuser.pays = _pays[0]; // Par défaut, le premier genre
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    List<Widget> _formulaires = <Widget>[
      GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(2006), // Date initiale
            firstDate: DateTime(1900), // Date minimale
            lastDate: DateTime(2012), // Date maximale
          );

          if (pickedDate != null) {
            setState(() {
              birthDay = pickedDate;
              newuser.dateBirthday = birthDay; // Met à jour la date de naissance de newuser
              dateController.text = DateFormat('dd-MM-yyyy').format(birthDay); // Met à jour le champ texte avec un format approprié
              print("newuser.dateBirthday : ${newuser.dateBirthday}");
            });
          }
        },

        child: AbsorbPointer(
          child: CustomTextField(
            xtextAlign: TextAlign.center, // Correction ici
            hintText: 'Entrez votre Date de naissance',
            controller: dateController,
            keyboardType: TextInputType.datetime,
            onChanged: (value) {
              setState(() {
                birthDay = DateTime.parse(value); // Si vous avez une logique pour cela
                newuser.dateBirthday = DateTime.tryParse(value) ?? DateTime.now(); // Utiliser tryParse pour éviter des erreurs
                print("newuser.dateBirthday : ${newuser.dateBirthday}");
              });
              // Optionnel : mettre à jour newuser.dateBirthday seulement si cela est nécessaire
              // Cela peut être évité si vous ne souhaitez pas que l'utilisateur entre manuellement une date
              // setState(() {
              //   birthDay = value; // Si vous avez une logique pour cela
              //   newuser.dateBirthday = DateTime.tryParse(value) ?? DateTime.now(); // Utiliser tryParse pour éviter des erreurs
              //   print("newuser.dateBirthday : ${newuser.dateBirthday}");
              // });
            },
          ),
        ),
      ),
      CustomTextField(
        xtextAlign: TextAlign.center,
        hintText: 'Entrez votre nom',
        controller: nomController,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            nom = value;
            newuser.nom = nom;
            print("this.newuser.nom : " + newuser.nom.toString());
          });
        },
      ),
      DropdownButtonFormField<Pays>(
        decoration: InputDecoration(
          hintText: 'Pays',
          border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF58CC02),
              width: 2.0,
            ),
          )
        ),
        value: newuser.pays,
        onChanged: (Pays? newValue) {
          setState(() {
            newuser.pays = newValue;
          });
        },
        items: _pays.map((Pays pays) {
          return DropdownMenuItem<Pays>(
            value: pays,
            child: Text(pays.pays), // Affiche le nom du genre
          );
        }).toList(),
      ),
      DropdownButtonFormField<GenreUser>(
        decoration: InputDecoration(
            hintText: 'Genre',
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF58CC02),
                width: 2.0,
              ),
            )
        ),
        value: newuser.genreUser,
        onChanged: (GenreUser? newValue) {
          setState(() {
            newuser.genreUser = newValue;
          });
        },
        items: _genreUser.map((GenreUser genre) {
          return DropdownMenuItem<GenreUser>(
            value: genre,
            child: Text(genre.genre), // Affiche le nom du genre
          );
        }).toList(),
      ),
      CustomTextField(
        xtextAlign: TextAlign.center,
        hintText: 'Entrez votre email',
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        errorText: _isEmailValid ? null : "Adresse e-mail invalide",
        onChanged: (value) {
          setState(() {
            email = value;
            newuser.email = email;
            print("newuser.email : " + newuser.email.toString());

            _isEmailValid = _validateEmail(email);
          });
        },
      ),
      CustomTextField(
        xtextAlign: TextAlign.center,
        hintText: 'Entrez votre mot de passe',
        isPassword: pass1,
        controller: passwordController,
        suffixIcon: IconButton(
          icon: Icon(pass1 ? Icons.visibility : Icons
              .visibility_off),
          onPressed: () {
            setState(() {
              pass1 =
              !pass1; // Change l'état du mot de passe
            });
          },
        ),
        onChanged: (value) {
          setState(() {
            firstpassword = value;
          });
        },
      ),
      CustomTextField(
        xtextAlign: TextAlign.center,
        hintText: 'Entrez votre mot de passe une nouvelle fois',
        isPassword: pass,
        controller: confirmerpasswordController,
        suffixIcon: IconButton(
          icon: Icon(pass ? Icons.visibility : Icons
              .visibility_off),
          onPressed: () {
            setState(() {
              pass =
              !pass; // Change l'état du mot de passe
            });
          },
        ),
        onChanged: (value) {
          setState(() {
            secondpassword = value;
          });
        },
      ),
    ];

    List<String> _formulairesTitre = <String>[
      "Quel est votre date de naissance?",
      "Quel est votre nom?",
      "Quel est votre nationnalité?",
      "Quel est votre genre?",
      "Quelle est votre adresse e-mail?",
      "Configurez votre mot de passe",
      "Confirmez votre mot de passe",
    ];


    double largeur = MediaQuery
        .of(context)
        .size
        .width;
    double hauteur = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: largeur,
          height: hauteur,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
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
                        if(_index > 0 && _index < _formulaires.length){
                          setState(() {
                            _index--;
                            print(_index);
                            print(_formulaires.length);
                          });
                        }else{
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 37),
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _formulairesTitre[_index],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF273958)
                      ),
                    ),
                    _formulaires[_index],
                    const SizedBox(height: 37),
                    Container(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        onPressed: () async {
                          // Fonction pour afficher les messages d'erreur
                          void showError(String message) {
                            Flushbar(
                              message: message,
                              duration: Duration(seconds: 3),
                              backgroundColor: Color(0xEFFF023B),
                              icon: const Icon(
                                Icons.check_circle_outline,
                                size: 28.0,
                                color: Colors.white,
                              ),
                              leftBarIndicatorColor: Colors.redAccent,
                            ).show(context);
                          }

                          // Fonction pour valider les champs
                          bool validateField(int index) {
                            switch (index) {
                              case 0:
                                return newuser.dateBirthday != DateFormat("dd-MM-yyyy").parse("31-12-1970");
                              case 1:
                                return newuser.nom!.isNotEmpty;
                              case 2:
                                return newuser.pays != null;
                              case 3:
                                return newuser.genreUser != null;
                              case 4:
                                return _isEmailValid;
                              case 5:
                                return firstpassword.isNotEmpty;
                              default:
                                return false;
                            }
                          }

                          // Gérer la transition entre les formulaires
                          if (_index < _formulaires.length - 1) {
                            if (validateField(_index)) {
                              setState(() {
                                _index++;
                                print(_index);
                              });
                            } else {
                              String errorMessage = "Ce champ ne peut pas rester vide";
                              showError(errorMessage);
                            }
                          } else if (_index == _formulaires.length - 1) {
                            // Dernière étape : validation des mots de passe
                            if (firstpassword == secondpassword) {
                              newuser.password = secondpassword;
                              print(this.newuser.toString());
                              int? token = await service.creerCompte("utilisateur/inscrireApprenant", newuser);
                              print(token);

                              if (token == 200 || token == 201 || token == 202) {
                                // Affichage de la boîte de dialogue de confirmation
                                bool? confirm = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Succès'),
                                      content: const Text('Inscription réussie avec succès'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true); // Retourne 'true'
                                          },
                                          child: Text('Continuer', style: TextStyle(color: Color(0xFF58CC02)),),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                // Redirection vers la page de connexion si confirmé
                                if (confirm == true) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Login()),
                                  );
                                }
                              } else {
                                showError("Echec lors de la création de votre compte. Veuillez réessayer.");
                              }
                            } else {
                              showError("Les mots de passe ne correspondent pas.");
                            }
                          }
                        },
                        child: const Text("Suivant", style: TextStyle(color: Color(0xFF000000), fontSize: 18, fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}

