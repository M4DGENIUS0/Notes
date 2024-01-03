import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/Pages/Login.dart';
import 'package:todoapp/Pages/Sign_up.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
        ),
        Container(
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text("HERE\nTHERE!",
                    style: GoogleFonts.bungee(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(131, 83, 105, 1))),
              ),
              Text(
                "Happy to See You Here!\nAgain Visit us",
                style: GoogleFonts.baloo2(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(131, 83, 105, 1)),
              ),
            ],
          ),
        ),

        // image here
        Container(
            height: 250,
            width: 390,
            child: Image.asset("assets/images/desktop.png")),
        SizedBox(
          height: 145,
        ),
        // Buttons for Login
        Container(
          width: 250,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEFFAFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side:
                          BorderSide(color: Color.fromRGBO(131, 83, 105, 1)))),
              child: Text(
                "Login",
                style: TextStyle(color: Color.fromRGBO(131, 83, 105, 1)),
              )),
        ),
        SizedBox(
          height: 15,
        ),
        // Buttons for Sign up
        Container(
          width: 250,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(131, 83, 105, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Sign_up(),
                    ));
              },
              child: Text(
                "Sign up",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    ));
  }
}
