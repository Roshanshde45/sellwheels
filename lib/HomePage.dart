import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellwheels/BuyingScreen.dart';
import 'package:sellwheels/SellerScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
      appBar: AppBar(
        title: Text("Select Seller Or Buyer"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Row(
               children: [
                 Expanded(child:  FlatButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => SellerScreen()));
                 }, child: Padding(
                     padding:EdgeInsets.symmetric(vertical: 40,horizontal: 8),child: Text("Seller")),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20),
                   ),
                   color: Colors.orange,
                 ),)
               ],
             ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child:  FlatButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BuyingScreen()));
                  }, child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40,horizontal: 8),
                      child: Text("Buyer")),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.grey,
                  ),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
