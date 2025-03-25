import 'package:dating_app/login_screen.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  var _gender = 'Female';

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
                      controller: emailController,
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
                      controller: passwordController,
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
                controller: passwordController,
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
                controller: dateController,
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
                controller: dateController,
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

              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration Successful!')),
                  );
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(
                width: double.infinity,
                height: 50,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()));
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
