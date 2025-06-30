import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/auth_api/auth_api_service.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/image_constants.dart';
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
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageConstants.logo,
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    "Welcome Back to Mynthra",
                    style: TextStyle(
                      fontFamily: 'MarckOne',
                      fontWeight: FontWeight.w400, // Normal
                      fontSize: 24,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Colors.black87,
                    ),
                    controller: userNameController,
                    decoration: InputDecoration(
                        labelText: "User Email",
                        labelStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Colors.grey[700],
                        ),
                        hintText: "Enter Email",
                        hintStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Colors.grey[700],
                        ),
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
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Colors.black87),
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Colors.grey[700],
                        ),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Colors.grey[700],
                        ),
                        prefixIcon: Icon(Icons.password),
                        //suffixIcon: Icon(Icons.email),

                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE91E63)),
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
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account",
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                        ),
                      ),
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
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                                color: Colors.pink.shade300),
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
