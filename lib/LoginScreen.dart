import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellwheels/HomePage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email,_password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

Future<void> login() async{
  if(_formKey.currentState.validate()) {
    _formKey.currentState.save();
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((value)
        => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())));
  }else{
    print("Validation Faliled");
  }
}

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Login",style: TextStyle(fontSize: 40),),
            SizedBox(height: 30,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                        prefixIcon: Icon(Icons.email)
                    ),
                    onSaved: (val){
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock)
                    ),
                    onSaved: (val){
                      setState(() {
                        _password = val;
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Expanded(
                  child: FlatButton(onPressed: login,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 17),
                        child: Text("Login",style: TextStyle(color: Colors.white),)),color: Colors.orange,
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
