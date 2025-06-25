import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/auth_api/auth_api_service.dart';
import 'package:whitematrix_groupa_shopping_app/views/auth/registration_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/home/home_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/widgets/bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();

    passwordController.dispose();

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
                    "Welcome Back to Mynthra",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                        labelText: "User Email",
                        hintText: "Entere Email",
                        prefixIcon: Icon(Icons.person),
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
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter Password",
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
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final email = userNameController.text.trim();
                        final password = passwordController.text;

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        final result =
                            await AuthService.loginUser(email, password);

                        Navigator.pop(context); // Close loading dialog

                        if (result != null) {
                          // Login successful – Navigate
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => BottomNavBar()),
                          );
                        } else {
                          // Show error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login failed')),
                          );
                        }
                      }
                    },
                    child: Text(
                      "LogIn",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("don't have an account"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: Text(
                            "Register",
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
