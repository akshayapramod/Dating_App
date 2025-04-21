import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

  var _gender = 'Female';

  // _____________________________Firebase Account registration & Authentication ___________________________________

  registerAuthentication(emailid, password, fName, lName, dob) async {
    try {
      var authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailid, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successfully Registered !'),
        backgroundColor: Colors.green,
      ));
      // if authitaction for registration scuceess?
      if (authResult.user!.uid.isNotEmpty) {
        var userId = authResult.user!.uid;
        //then save data into firestore db

        FirebaseFirestore db = FirebaseFirestore.instance;

        Map<String, String> detail = {
          "Firstname": fName,
          "Lastname": lName,
          "DOB": dob,
          "Email": emailid,
          "Password": password,
          "Gender": _gender,
        };

        db
            .collection("userdetails")
            .doc(userId)
            .set(detail)
            .onError((e, _) => print("Error writing document: $e"));

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
    }
  }
  //_________________________________________________________________________________________________________________________

  List<String> genderItems = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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

              Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: TextField(
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
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 170,
                    child: TextField(
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
              TextField(
                onTap: () async {
                  DateTime fDate = DateTime(1900);
                  DateTime lDate = DateTime(2005);
                  var dt = await showDatePicker(
                      context: context, firstDate: fDate, lastDate: lDate);
                  var year = dt!.year;
                  var mnth = dt!.month;
                  var day = dt!.day;

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
              TextField(
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
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                
                  prefixIcon:
                      const Icon(Icons.remove_red_eye, color: Colors.pink),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(obscureText: false,
                controller: confPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon:
                      const Icon(Icons.remove_red_eye, color: Colors.pink),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  var email = emailController.text;
                  var passwrd = passwordController.text;
                  var fname = firstNameController.text;
                  var lName = lastNameController.text;
                  var dob = dateController.text;
                  var cpass = confPasswordController.text;
                  if(cpass== passwrd){

                  registerAuthentication(email, passwrd, fname, lName, dob);
                  }
                  else{
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password mismatch'),
        backgroundColor: Colors.orange,
      ));
                  }

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Registration Successful!')),
                  // );
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
    );
  }
}
