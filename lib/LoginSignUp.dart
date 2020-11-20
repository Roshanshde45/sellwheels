import 'package:flutter/material.dart';
import 'package:sellwheels/LoginScreen.dart';
import 'package:sellwheels/SignUpScreen.dart';

class LoginSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/wheels.jpg",height: 400,),
            Row(
              children: [
                Expanded(
                  child: FlatButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen()));
                  },
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                        child: Text("Login")),color: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  child: FlatButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>SignUpScreen()));
                  },
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                        child: Text("Register")),color: Colors.grey[400],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
