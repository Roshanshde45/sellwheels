import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellwheels/HomePage.dart';
import 'package:sellwheels/SellerScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _name,_email,_password,_address,_phone;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> signUp() async{
    String uid;
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password).then((value) => print("User Created Successfully"));
        uid = FirebaseAuth.instance.currentUser.uid;
        await FirebaseFirestore.instance.collection("Users").doc(uid).set({
          "name": _name,
          "address": _address,
          "phone": _phone,
        }).then((value) => print("Data Added"));
      }catch(e) {
        print(e);
      }
    }else{
      print("Valodation Failed");
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Create an Account",style: TextStyle(fontSize: 40),),
              SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person)
                      ),
                      onSaved: (val){
                       setState(() {
                         _name = val;
                       });
                      },
                    ),
                    SizedBox(height: 20,),
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
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Address",
                          prefixIcon: Icon(Icons.location_pin)
                      ),
                      onSaved: (val){
                        setState(() {
                          _address = val;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Phone",
                          prefixIcon: Icon(Icons.phone)
                      ),
                      onSaved: (val){
                       setState(() {
                         _phone = val;
                       });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Row(
                children: [
                  Expanded(
                    child: FlatButton(onPressed: () {
                      signUp();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 17),
                          child: Text("SignUp",style: TextStyle(color: Colors.white),)),color: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
