import 'package:flutter/material.dart';
import 'package:sellwheels/Models/CarDetails.dart';

import 'SubmitScreen.dart';


class SellerScreen extends StatefulWidget {
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  String _carName,_discrib;
  int _driven,_enginePercent,_bodyPercent,_buyYear;
  double _onRoad,_calculatedPrice = 0.0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _offerPrice = new TextEditingController();


  void CalculatePrice() {
    int i;
    double totalRoadPrice = 0,m,n;
    int yearold = 0,currentYear = 2020;
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      print(_buyYear);
      yearold = currentYear - _buyYear;
      print(yearold);
      totalRoadPrice = _onRoad;
        for(i=1;i<=yearold;i++){
          m = totalRoadPrice * 0.1;
          totalRoadPrice = totalRoadPrice - m;
        }
        print("Year: $totalRoadPrice");

        if(_driven>20000){
          n = totalRoadPrice * 0.08;
          totalRoadPrice = totalRoadPrice - n;
        }
      print("Driven: $totalRoadPrice");

        if(_enginePercent < 10){
          totalRoadPrice = totalRoadPrice/2;
        }else if(_enginePercent>=10 && _enginePercent<=50){
          totalRoadPrice = totalRoadPrice/1.5;
        }else if(_enginePercent>=50 && _enginePercent<=80){
          totalRoadPrice = totalRoadPrice/1.25;
        }else{
          print(totalRoadPrice);
        }//Engine Condition Calculates
        print("Engine: $totalRoadPrice");

        if(_bodyPercent < 10){
          totalRoadPrice = totalRoadPrice/2;
        }else if(_bodyPercent>=10 && _bodyPercent<=50){
          totalRoadPrice = totalRoadPrice/1.5;
        }else if(_bodyPercent>=50 && _bodyPercent<=80){
          totalRoadPrice = totalRoadPrice/1.25;
        }else{
          print(totalRoadPrice);
        }//Body Condition Calculated
        print("Body: $totalRoadPrice");
        setState(() {
          _calculatedPrice = totalRoadPrice;
        });
        print(totalRoadPrice);
    }else{
      print("Error");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed Car Details"),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: (){
           _formKey.currentState.reset();
          },tooltip: "Reset Form",)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Car Name",
                      ),
                      validator: (val) {
                        if(val.isEmpty){
                          return "Car name required";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          _carName = val;
                        });
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Buy Year",
                      ),
                      validator: (val) {
                        if(val.isEmpty){
                          return "Buy Year required";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          _buyYear = int.parse(val);
                        });
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Description",
                            helperText: "eg. color,added accessories,audiosystem,seatcover..."
                        ),
                        validator: (val) {
                          if(val.isEmpty){
                            return "Discription required";
                          }
                        },
                        onSaved: (val) {
                          setState(() {
                            _discrib = val;
                          });
                        },
                        keyboardType: TextInputType.text
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "On Road Price",
                      ),
                      validator: (val) {
                        if(val.isEmpty){
                          return "On road price required";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          _onRoad = double.parse(val);
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Driven (Km)",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if(val.isEmpty){
                          return "Driven distance required";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          _driven = int.parse(val);
                        });
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Engine Condition(%)",
                          helperText: "Includes gearbox, Drive shaft, Drive Train..."
                      ),
                      validator: (val) {
                        if(val.isEmpty){
                          return "Car name required";
                        }else if(int.parse(val)>100){
                          return "Should be less than 100";
                        }else if(int.parse(val)<0){
                          return "Should be greater than 0";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          _enginePercent = int.parse(val);
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Body Condition(%)",
                          helperText: "Includes Tyre, Interior, HeadLights..."
                      ),
                      validator: (val) {
                        if(val.isEmpty){
                          return "Car name required";
                        }else if(int.parse(val)>100){
                          return "Should be less than 100";
                        }else if(int.parse(val)<0){
                          return "Should be greater than 0";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          _bodyPercent = int.parse(val);
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25,),
              RichText(
                text: TextSpan(
                  text: "Calculated Price: ",style: TextStyle(color: Colors.black,fontSize: 27),
                  children: [
                    TextSpan(text: _calculatedPrice.round().toString(),style: TextStyle(color: Colors.red,fontSize: 27)),
                  ]
                ),
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Expanded(
                    child:  FlatButton(
                      onPressed: () {
                        CalculatePrice();
                        showDialog(context: context,builder: (BuildContext context){
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            title: Text("Offer Customer Price"),
                            content: Container(
                              height: MediaQuery.of(context).size.height*0.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Car Value: ${_calculatedPrice.round().toString()}"),
                                  Text("Offer Price: "),
                                  TextField(keyboardType: TextInputType.number,
                                  controller: _offerPrice,
                                  ),
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitScreen(
                                            carDet: CarDetails(
                                              carName: _carName,
                                              description: _discrib,
                                              buyYear: _buyYear,
                                              driven: _driven,
                                              offerPrice: int.parse(_offerPrice.text),
                                              carValue: _calculatedPrice
                                            )
                                          )));
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
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 8),
                        child: Text("Calculate")),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.orange,
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
