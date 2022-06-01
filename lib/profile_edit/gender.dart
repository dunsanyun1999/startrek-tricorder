import 'package:flutter/material.dart';
import '/profile_edit/age.dart';

class editUser_Gender extends StatelessWidget {
  final String name;
  editUser_Gender({required this.name});


  @override
  Widget build(BuildContext context) {
    Route route_male = MaterialPageRoute(builder: (context) =>
        editUser_Age(name: name, is_male:true));
    Route route_female = MaterialPageRoute(builder: (context) =>
        editUser_Age(name: name, is_male:false));
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Center(child: Text(name + ",\nWhat is your gender?",
                  style: TextStyle(fontSize:30),
                  textAlign:TextAlign.center )),
              SizedBox(
                height: 50
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                    Ink(
                        decoration: const ShapeDecoration(
                            color: Colors.blue,
                            shape: CircleBorder(),
                        ),
                        child: IconButton(icon: Icon(Icons.man),
                          iconSize: 100,
                          color: Colors.white,
                          onPressed: () => {
                          Navigator.pushReplacement(context, route_male)
                    })),
                  Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.red,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(icon: Icon(Icons.woman),
                          iconSize: 100,
                          color: Colors.white,
                          onPressed: () => {
                            Navigator.pushReplacement(context, route_female)
                          })
                  ),
                ]
              ),

            ]
          )
      ),
    );
  }

}