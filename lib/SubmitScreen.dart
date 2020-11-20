import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellwheels/HomePage.dart';
import 'package:sellwheels/Models/CarDetails.dart';

class SubmitScreen extends StatefulWidget {
  CarDetails carDet;

  SubmitScreen({this.carDet});
  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
String uid;
String address,name,phone,email;


  Future<void> saveCarData() async{
    await FirebaseFirestore.instance.collection("CarsToBuy").add({
      "carName": widget.carDet.carName,
      "description": widget.carDet.description,
      "buyYear": widget.carDet.buyYear,
      "driven": widget.carDet.driven,
      "offer":widget.carDet.offerPrice,
      "carValue": widget.carDet.carValue,
      "name": name,
      "emailId": email,
      "address": address,
      "phone":phone,
    }).then((value) => print("data Added Succesfully"));
  }

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser.uid;
    email = FirebaseAuth.instance.currentUser.email;
    super.initState();
    getDetails();
  }


  Future<void> getDetails() async{
    await FirebaseFirestore.instance.collection("Users").doc(uid).get().then((doc){
      setState(() {
        name = doc.data()["name"];
        address = doc.data()["address"];
        phone = doc.data()["phone"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDAE0E2),
      appBar: AppBar(
        title: Text("Submission"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height*0.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      children: [
                        // Text("Details",style: TextStyle(fontSize: 33),),
                        Icon(Icons.check,size: 100,color: Colors.greenAccent,),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Offering Price: ",style: TextStyle(fontSize: 30),),
                            Text("${widget.carDet.offerPrice} ₹",style: TextStyle(fontSize: 22),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Car Value ",style: TextStyle(fontSize: 30),),
                            Text("${widget.carDet.carValue} ₹",style: TextStyle(fontSize: 22),),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Car Name: "),
                            Text(widget.carDet.carName.toString())
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Description: "),
                            Text(widget.carDet.description.toString())
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Bought Year: "),
                            Text(widget.carDet.buyYear.toString())
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Driven: "),
                            Text(widget.carDet.driven.toString())
                          ],
                        ),
                        SizedBox(height: 50,),
                        FlatButton(onPressed: () {
                          saveCarData();
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage()));
                        },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                            child: Text("Submit")),color: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),)
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
