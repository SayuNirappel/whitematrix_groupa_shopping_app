import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/auth_api/auth_api_service.dart';
import 'package:whitematrix_groupa_shopping_app/views/auth/login_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/home/home_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/widgets/bottom_nav_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController confirmUNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    confirmUNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to Mynthra",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Email",
                        prefixIcon: Icon(Icons.email),
                        //suffixIcon: Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      }
                      if (!value.contains("@")) {
                        return "Enter a valid Email";
                      }
                      return null;
                    },
                  ),
                  // TextFormField(
                  //   controller: userNameController,
                  //   decoration: InputDecoration(
                  //       labelText: "User Name",
                  //       hintText: "Create User Name",
                  //       prefixIcon: Icon(Icons.person),
                  //       //suffixIcon: Icon(Icons.email),
                  //       filled: true,
                  //       fillColor: Colors.grey.shade200,
                  //       contentPadding: const EdgeInsets.symmetric(
                  //         vertical: 20,
                  //         horizontal: 20,
                  //       ),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(12),
                  //           borderSide: BorderSide.none)),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Please enter username";
                  //     }
                  //     if (value.length < 6) {
                  //       return "Weak Username";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // TextFormField(
                  //   controller: confirmUNameController,
                  //   decoration: InputDecoration(
                  //       labelText: "Confirm Username",
                  //       hintText: "Re enter your User Name",
                  //       prefixIcon: Icon(Icons.verified),
                  //       //suffixIcon: Icon(Icons.email),
                  //       filled: true,
                  //       fillColor: Colors.grey.shade200,
                  //       contentPadding: const EdgeInsets.symmetric(
                  //         vertical: 20,
                  //         horizontal: 20,
                  //       ),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(12),
                  //           borderSide: BorderSide.none)),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Please re-enter your username";
                  //     }
                  //     if (value != userNameController.text) {
                  //       return "Wrong username";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Create Password",
                        prefixIcon: Icon(Icons.password),
                        //suffixIcon: Icon(Icons.email),

                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Password";
                      }
                      if (value.length < 6) {
                        return "Weak Password";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Re Enter your password to confirm",
                        prefixIcon: Icon(Icons.verified),
                        //suffixIcon: Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Password";
                      }
                      if (value != passwordController.text) {
                        return "Wrong Password";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                                child: CircularProgressIndicator()),
                          );

                          final user = await AuthService.registerUser(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );

                          Navigator.pop(context); // remove the loading dialog

                          if (user != null) {
                            // Optionally save user.token or user.user!.id using SharedPreferences
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Registered Successfully!")),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                            );
                          }
                        } catch (e) {
                          Navigator.pop(context); // remove the loading dialog

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "Registration Failed: ${e.toString()}")),
                          );
                        }
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("If already have an account"),
                      TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
