import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/my_container.dart';
import 'package:login_app/my_textfield.dart';
import 'package:login_app/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSpinner = false;

  void _signUp() async {
    setState(() {
      showSpinner = true;
    });

    try {
      final newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (newUser.user != null) {
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up successfully!'),
            backgroundColor: Colors.blue,
          ),
        );
        // 회원가입 성공 후 로그인 화면으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something wrong with sign up process!'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: showSpinner
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Image.asset('assets/images/logo.png', width: 150, height: 150)
                          .animate()
                          .fade()
                          .slideY(begin: -3, end: 0)
                          .animate(onPlay: (controller) => controller.repeat())
                          .shake(
                            hz: 4,
                            curve: Curves.easeInOutCirc,
                            duration: 1800.ms,
                          ),

                      SizedBox(height: 5),

                      Text(
                            'Welcome!',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                          .animate()
                          .fade(delay: 500.ms)
                          .slideX(begin: -2, end: 0)
                          .tint(color: Colors.purple, delay: 1000.ms),
                      const SizedBox(height: 5),

                      Text(
                        'Sign up to continue',
                        style: TextStyle(color: Colors.grey[700]),
                      ).animate().fade(delay: 500.ms).slideX(begin: 2, end: 0),

                      const SizedBox(height: 25),
                      MyTextfield(
                        hintText: 'Email',
                        obscureText: false,
                        controller: emailController,
                        emailType: true,
                      ),
                      SizedBox(height: 25),
                      MyTextfield(
                        hintText: 'Password',
                        obscureText: true,
                        controller: passwordController,
                        emailType: false,
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: _signUp,
                        child: MyContainer(
                          width: 120,
                          height: 50,
                          backgroundColor: Colors.orange[200],
                          radius: 20,
                          icon: const Icon(Icons.arrow_forward),
                        ).animate().fade(delay: 1000.ms),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a member?',
                            style: TextStyle(color: Colors.grey[700]),
                          ).animate().fade().slideX(
                            begin: -3,
                            end: 0,
                            duration: 300.ms,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                            },
                            child:
                                const Text(
                                  'Log in',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).animate().fade().slideX(
                                  begin: 3,
                                  end: 0,
                                  duration: 300.ms,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            'Powered by Sungkyul Univ',
                            style: TextStyle(fontSize: 11),
                          ).animate().fade().slideX(begin: -3, end: 0, delay: 300.ms),
                          MyContainer(
                                width: 50,
                                height: 50,
                                backgroundColor: Colors.grey[300],
                                imagePath: 'assets/images/minilogo.png',
                                radius: 16.0,
                              )
                              .animate()
                              .slideX(begin: 3, end: 0, duration: 300.ms)
                              .animate(onPlay: (controller) => controller.repeat())
                              .shimmer(delay: 1000.ms, duration: 1800.ms),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
