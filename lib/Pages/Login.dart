import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart'
    as slideDialog;
import 'package:todoapp/Pages/Sign_up.dart';
import 'package:todoapp/Pages/home.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formStateKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController _Email = TextEditingController();
  TextEditingController _Passwd = TextEditingController();

  @override
  void dispose() {
    _Email.dispose();
    _Passwd.dispose();
    super.dispose();
  }

  // validation Email format
  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //Flutter Firebase
  Future signIn() async {
    setState(() {
      loading = false;
    });
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _Email.text.trim(),
      password: _Passwd.text.trim(),
    )
        .then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      print(error.toString());
      final snackbar = SnackBar(
        content: Text(error.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    });
  }

  @override

// Pop up dialog

  void _showDialog() {
    slideDialog.showSlideDialog(
      pillColor: Color.fromRGBO(131, 83, 105, 1),
      context: context,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Forgot Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 58,
                  ),
                  Text("Type your Email here"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Email Here",
                        helperText: "Reset Password Here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(131, 83, 105, 1)))),
                  )),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(131, 83, 105, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {},
                      child: Text(
                        "Request Password Reset",
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }

//  for password visibility
  @override
  bool _password = false;
  bool _obsecuretext = true;
  void toggle() {
    setState(() {
      _password = !_password;
      _obsecuretext = !_obsecuretext;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 89,
            ),
            // Icon here
            Icon(
              Icons.lock_person_rounded,
              size: 100,
              color: Color.fromRGBO(131, 83, 105, 1),
            ),
            SizedBox(
              height: 15,
            ),
            //Text here
            Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(17, 8, 12, 1),
              ),
            ),
            Text(
              "Make it worth, Make it Right, Make it Fast",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(17, 8, 12, 1),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: _formStateKey,
              child: Column(
                children: [
                  // Email
                  SizedBox(
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          bool emailValid = RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(value!);
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }
                        },
                        controller: _Email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email",
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.email_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14))),
                      )),

                  SizedBox(
                    height: 15,
                  ),
                  // Password
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _Passwd,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Kindly Enter Password";
                        }
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obsecuretext,
                      decoration: InputDecoration(
                          labelText: "Password",
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                              onPressed: toggle,
                              icon: Icon(_password
                                  ? Icons.visibility_off_rounded
                                  : Icons.remove_red_eye_rounded)),
                          prefixIcon: Icon(Icons.fingerprint_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14))),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 180),
              child: TextButton(
                  onPressed: () {
                    setState(() {});
                    _showDialog;
                  },
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            // Login button here
            Container(
              width: 250,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(131, 83, 105, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    if (_formStateKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      signIn();
                    }
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )
                      : Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 2,
                  color: Color(0xffA2A2A2),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "OR",
                  style: TextStyle(color: Color(0xffA2A2A2), fontSize: 15),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  height: 2,
                  color: Color(0xffA2A2A2),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Error',
                          text: 'Sorry, This feature will added soon!',
                          confirmBtnColor: Color.fromRGBO(131, 83, 105, 1),
                        );
                      },
                      child: Container(
                          child: Image.asset('assets/images/google.png'))),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 80,
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Error',
                          text: 'Sorry, This feature will added soon!',
                          confirmBtnColor: Color.fromRGBO(131, 83, 105, 1),
                        );
                      },
                      child: Container(
                          child: Image.asset('assets/images/apple.png'))),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not Registered?"),
                InkWell(
                  child: Text(
                    " Sign up",
                    style: TextStyle(
                        color: Color.fromRGBO(131, 83, 105, 1),
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Sign_up()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
