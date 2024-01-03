import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:todoapp/Pages/Login.dart';
import 'package:todoapp/Pages/home.dart';
import 'package:firebase_database/firebase_database.dart';

class Sign_up extends StatefulWidget {
  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final dbref = FirebaseDatabase.instance.ref('StoreData');
  final _formStateKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController _Name = TextEditingController();
  TextEditingController _Email = TextEditingController();
  TextEditingController _Passwd = TextEditingController();

  @override
  void dispose() {
    _Name.dispose();
    _Email.dispose();
    _Passwd.dispose();
    super.dispose();
  }

  // Sign up page
  Future sign_up() async {
    setState(() {
      loading = true;
    });
    dbref
        .child(DateTime.now()
            .format(AmericanDateFormats.standardWithComma)
            .toString())
        .set({
      'ID': DateTime.now()
          .format(AmericanDateFormats.standardWithComma)
          .toString(),
      'Name': _Name.text,
      'Email': _Email.text,
      'Password': _Passwd
    });
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: _Email.text.toString(),
      password: _Passwd.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
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

// Password Visible and non visible
  @override
  bool _passwordVisible = false;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _passwordVisible = !_passwordVisible;
    });
  }

// initial state of password
  void initState() {
    _passwordVisible = false;
  }

  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                // Icon here
                Icon(
                  Icons.lock_outline_rounded,
                  size: 100,
                  color: Color.fromRGBO(131, 83, 105, 1),
                ),
                SizedBox(
                  height: 10,
                ),

                // welcome here
                Text(
                  "Create account account, It Freee!!!!",
                  style: TextStyle(
                      color: Color.fromRGBO(75, 47, 62, 1),
                      fontSize: 15,
                      fontFamily: "PhoDu"),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                    key: _formStateKey,
                    child: Column(
                      children: [
                        // First Name
                        SizedBox(
                            width: 300,
                            child: TextFormField(
                              validator: (value) {
                                bool nameValid = RegExp(
                                        r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                                    .hasMatch(value!);
                                if (value.isEmpty) {
                                  return "Please Enter name";
                                }
                              },
                              controller: _Name,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle_rounded,
                                    size: 30,
                                  ),
                                  labelText: "Username",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              131, 83, 105, 1)))),
                            )),

                        SizedBox(
                          height: 10,
                        ),

                        // Email Here
                        SizedBox(
                            width: 300,
                            child: TextFormField(
                              validator: (value) {
                                bool emailValid = RegExp(
                                        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                    .hasMatch(value!);
                                if (value.isEmpty) {
                                  return "Enter Email Address";
                                }
                              },
                              controller: _Email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email_rounded,
                                    size: 30,
                                  ),
                                  labelText: "Email",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              131, 83, 105, 1)))),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        // Password here
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                              controller: _Passwd,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.fingerprint_rounded),
                                  suffixIcon: IconButton(
                                      onPressed: () => _toggle(),
                                      icon: Icon(_passwordVisible
                                          ? Icons.visibility_off_rounded
                                          : Icons.remove_red_eye_rounded)),
                                  labelText: "Password",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              131, 83, 105, 1))))),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // Confirm password here
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.fingerprint_rounded),
                                  suffixIcon: IconButton(
                                      onPressed: _toggle,
                                      icon: Icon(_passwordVisible
                                          ? Icons.visibility_off_rounded
                                          : Icons.remove_red_eye_rounded)),
                                  labelText: "Confirm Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(131, 83, 105, 1))),
                                  fillColor: Colors.white)),
                        ),
                      ],
                    )),

                SizedBox(
                  height: 20,
                ),
                // Sign up button here

                Container(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(131, 83, 105, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        if (_formStateKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                            sign_up();
                          });
                        }
                      },
                      child: loading
                          ? CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            )
                          : Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                ),
                SizedBox(
                  height: 20,
                ),
                // else here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      color: Color(0xffA2A2A2),
                      width: 100,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(fontSize: 15, color: Color(0xffA2A2A2)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 2,
                      color: Color(0xffA2A2A2),
                      width: 100,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // other sign up option

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 80,
                        height: 80,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Error',
                                text: 'Sorry, This feature will added soon!',
                                confirmBtnColor:
                                    Color.fromRGBO(131, 83, 105, 1),
                              );
                            },
                            child: Image.asset('assets/images/google.png'))),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                        width: 80,
                        height: 80,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Error',
                                text: 'Sorry, This feature will added soon!',
                                confirmBtnColor:
                                    Color.fromRGBO(131, 83, 105, 1),
                              );
                            },
                            child: Image.asset('assets/images/apple.png')))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have Account! ",
                      style: TextStyle(fontSize: 15),
                    ),
                    InkWell(
                      child: Text(
                        "Login Here",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(131, 83, 105, 1),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
