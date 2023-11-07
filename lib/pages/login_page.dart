import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>(); // used for OTP

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: Cross,
        children: [
          Text(
            "Hi, welcome back",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          Text("Enter your mobile no. "),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                  prefixText: "+91",
                  labelText: "Enter your phone no ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32))),
              validator: (value) {
                if (value!.length != 10) return "Invalid Phone No ";
                return null;
              },
            ),
          ),
          OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: Text("Send OTP "))
        ],
      ),
    );
  }
}
