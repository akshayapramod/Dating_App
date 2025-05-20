import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/login_screen.dart';
import 'package:dating_app/your_interests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confPasswordController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController imageController = TextEditingController();

  var _gender = 'Female';

  final _formKey = GlobalKey<FormState>();

  // _____________________________Firebase Account registration & Authentication ___________________________________

  registerAuthentication(emailid, password, fName, lName, dob, img) async {
    try {
      var authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailid, password: password);

      // if authitaction for registration scuceess?
      if (authResult.user!.uid.isNotEmpty) {
        var userId = authResult.user!.uid;
        //then save data into firestore db

        // Shared preferences instance calling

        SharedPreferences pref = await SharedPreferences
            .getInstance(); //user id nxt page le kittan vendi

        await pref.setString("lastRegisteredUid",
            userId); //persistant memmory :-non volatile  memmory(volatile:-cash pole ulla memmory(cash: temporary aayi save cheyyunna memmory))

        FirebaseFirestore db = FirebaseFirestore.instance;

        Map<String, String> detail = {
          "Firstname": fName,
          "Lastname": lName,
          "DOB": dob,
          "Email": emailid,
          "Password": password,
          "Gender": _gender,
          "Image": img,
        };

        await db
            .collection("userdetails")
            .doc(userId)
            .set(detail)
            .onError((e, _) => print("Error writing document: $e"));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Successfully Registered !'),
          backgroundColor: Colors.green,
        ));

        if (!context.mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return InterestScreen();
          },
        ));

// Update one field, creating the document if it does not already exist.
// final data = {"capital": true};
// db.collection("userdetails").doc("BJ").set(data, SetOptions(merge: true));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${e.code}'),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${e}'),
        backgroundColor: Colors.red,
      ));
    } finally {
      firstNameController.clear();
      lastNameController.clear();
      dateController.clear();
      emailController.clear();
      passwordController.clear();
      confPasswordController.clear();
      imageController.clear();
    }
  }
  //_________________________________________________________________________________________________________________________

  List<String> genderItems = ['Male', 'Female', 'Other'];

  String? myImage = '';
  bool passwordSecure = true;
  bool cpasswordSecure = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Logo / Title
                  const Text(
                    "❤️ Love Connect ❤️",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      // var img = await ImagePicker()
                      //     .pickImage(source: ImageSource.gallery);
                      // myImage = NetworkImage(img!.path);
                      // setState(() {

                      // });
                    },
                    child: myImage == ''
                        ? CircleAvatar(
                            child: Icon(Icons.person_2_rounded),
                            radius: 60,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(myImage!),
                            radius: 60,
                          ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please upload a photo";
                      }
                      final imgregex = RegExp('https?:\/\/.*\.(?:png|jpg)');
                      if (!imgregex.hasMatch(value)) {
                        return "Enter a proper Image URL";
                      }

                      return null;
                    },
                    onChanged: (value) {
                      myImage = value.toString();
                      setState(() {});
                    },
                    controller: imageController,
                    decoration: InputDecoration(
                      labelText: "Image",
                      prefixIcon: const Icon(
                        Icons.image,
                        color: Colors.pink,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: width * .4,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a name";
                            }
                            return null;
                          },
                          controller: firstNameController,
                          decoration: InputDecoration(
                            labelText: "First Name",
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.pink),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: width * .4,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a name";
                            }
                            return null;
                          },
                          controller: lastNameController,
                          decoration: InputDecoration(
                              labelText: "Last Name",
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.pink,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  // TextField(
                  //   controller: passwordController,
                  //   decoration: InputDecoration(
                  //       labelText: "Gender",
                  //       prefixIcon: const Icon(
                  //         Icons.radio_button_checked,
                  //         color: Colors.pink,
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       )),

                  // ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Gender",
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.pink,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    items: genderItems.map((element) {
                      return DropdownMenuItem<String>(
                        value: element,
                        child: Text(element),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _gender = value.toString();
                      // setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onTap: () async {
                      DateTime fDate = DateTime(1900);
                      DateTime lDate = DateTime(2005);
                      var dt = await showDatePicker(
                          context: context, firstDate: fDate, lastDate: lDate);
                      var year = dt!.year;
                      var mnth = dt.month;
                      var day = dt.day;

                      var dob = "$year-$mnth-$day";
                      dateController.text = dob;
                      setState(() {});
                    },
                    controller: dateController,
                    decoration: InputDecoration(
                        labelText: "Date of Birth",
                        prefixIcon: const Icon(
                          Icons.calendar_month,
                          color: Colors.pink,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Email";
                      }
                      final emailregex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (emailregex.hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email, color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: passwordSecure,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.remove_red_eye,
                            color: Colors.pink),
                        onPressed: () {
                          passwordSecure = !passwordSecure;
                          setState(() {});
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    obscureText: cpasswordSecure,
                    controller: confPasswordController,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      prefixIcon: IconButton(
                          onPressed: () {
                            cpasswordSecure = !cpasswordSecure;
                            setState(() {});
                          },
                          icon: const Icon(Icons.remove_red_eye,
                              color: Colors.pink)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var email = emailController.text;
                        var passwrd = passwordController.text;
                        var fname = firstNameController.text;
                        var lName = lastNameController.text;
                        var dob = dateController.text;
                        var cpass = confPasswordController.text;
                        var img = imageController.text;
                        if (cpass == passwrd) {
                          registerAuthentication(
                              email, passwrd, fname, lName, dob, img);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Password mismatch'),
                            backgroundColor: Colors.orange,
                          ));
                        }

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Registration Successful!')),
                        // );
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 50,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "Already have an account ? Login",
                        style: TextStyle(fontSize: 17),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
