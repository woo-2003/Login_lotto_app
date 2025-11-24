import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:login_app/my_container.dart';
import 'package:login_app/my_textfield.dart';
import 'package:login_app/lotto.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email == 'email@email.com' && password == '123456') {
      // 로그인 성공
      Navigator.push(context, MaterialPageRoute(builder: (context) => Lotto()));
    } else if (email == 'email@email.com' && password != '123456') {
      // 이메일만 맞고 비번 틀림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('비밀번호를 확인하세요'), backgroundColor: Colors.red),
      );
    } else if (email != 'email@email.com' && password == '123456') {
      // 이메일 틀리고 비번 맞음
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이메일을 확인하세요'), backgroundColor: Colors.red),
      );
    } else {
      // 둘 다 틀림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 정보를 확인하세요'), backgroundColor: Colors.red),
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
            child: Column(
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
                      'Welcome Back!',
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
                  'Sign in to continue',
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
                  onTap: _login,
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
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ).animate().fade().slideX(
                      begin: -3,
                      end: 0,
                      duration: 300.ms,
                    ),
                    TextButton(
                      onPressed: () {},
                      child:
                          const Text(
                            'Register Now',
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
