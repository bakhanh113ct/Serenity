import 'package:flutter/material.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/repository/AuthRepository.dart';
import 'package:serenity/widget/CustomButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController= TextEditingController();
  final _passController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width:double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: size.height-MediaQuery.of(context).padding.top,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                "Serenity",
                                style: TextStyle(
                                  fontFamily: 'Lobster',
                                  fontSize: 36,
                                  color: CustomColor.second,
                                  decoration: TextDecoration.none,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              const SizedBox(height: 130,),
                              Text(
                                "Welcome back",
                                style: TextStyle(
                                    fontSize: 36,
                                    color: CustomColor.second,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              ),
                              Text("Please enter your detail",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: CustomColor.second,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 60),
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      label: const Text('Email'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      hintText: 'Enter your email',
                                    ),
                                ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: TextField(
                                    controller: _passController,
                                    decoration: InputDecoration(
                                      label: const Text('Password'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      hintText: 'Enter your password',
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Forgot Password?", style: TextStyle(color: CustomColor.second,fontWeight: FontWeight.w600,fontSize: 16)))
                                ],),
                              ),
                              const SizedBox(height: 30,),
                              CustomButton(onTap: () {
                                AuthRepository().SignIn(_emailController.text, _passController.text);
                              },
                              child: const Text("Login"),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container( 
                    height: size.height-MediaQuery.of(context).padding.top,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/background.png',),fit: BoxFit.cover)
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
