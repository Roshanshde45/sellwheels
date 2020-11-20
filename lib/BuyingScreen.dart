import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuyingScreen extends StatefulWidget {
  @override
  _BuyingScreenState createState() => _BuyingScreenState();
}

class _BuyingScreenState extends State<BuyingScreen> {
List carList = [];
String email,phone;

  Future<void> getCarsData() async{
    List pList = [];
    var result = await Firestore.instance.collection("CarsToBuy").get().then((QuerySnapshot snapshot) {
      for(var doc in snapshot.docs){
        pList.add(doc.data());
      }
    });
    setState(() {
      carList = pList;
    });
  }

  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser.email;
    super.initState();
    getCarsData();
    carList.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("On Sale Cars"),
      ),
      body: ListView.builder(itemBuilder: (context,i){
        return CarDetailCard(
          sellerName: carList[i]["name"],
          address: carList[i]["address"],
          carName: carList[i]["carName"],
          carvalue: carList[i]["carValue"],
          sellerOffer: carList[i]["offer"],
          description: carList[i]["description"],
          phone:  carList[i]["phone"],
          email: carList[i]["emailId"],
        );
      },
        itemCount: carList.length,
      ),
    );
  }
}

class CarDetailCard extends StatelessWidget {
  final String sellerName;
  final String carName;
  final String address;
  final String email;
  final String description;
  final double carvalue;
  final int sellerOffer;
  final String phone;
   const CarDetailCard({
      this.sellerName,
     this.phone,
     this.email,
     this.description,
     this.address,
     this.carName,
     this.carvalue,
     this.sellerOffer,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(13),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)
        ),
        elevation: 1,
        child: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.topLeft,
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: $sellerName",),
              SizedBox(height: 8,),
              Text("Car Name $carName",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Text("Address $address"),
              SizedBox(height: 8,),
              Text("Car Value $carvalue",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Text("Seller Offer ${sellerOffer.truncate().toString()}",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Text("Description:  "),
              SizedBox(height: 8,),
              Padding(
                padding: EdgeInsets.only(left: 20),
                  child: Text(description,maxLines: 5,)),
              Row(
                children: [
                  Expanded(
                    child: FlatButton(onPressed: () {
                      showDialog(context: context,builder: (BuildContext context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          title: Text("Contact"),
                          content: Container(
                            height: MediaQuery.of(context).size.height*0.15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15,),
                                Text("Email: $email"),
                                Text("Phone: $phone"),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text("Cancel",
                                          style: TextStyle(color: Colors.white),),
                                      ),color: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    FlatButton(
                                      onPressed: () {

                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text("Submit",
                                          style: TextStyle(color: Colors.white),),
                                      ),color: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                    },
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 8),
                          child: Text("Contact")),color: Colors.orange,
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
