import 'package:flutter/material.dart';
import 'package:flutter_camera_demo/homepage.dart';

class newUser extends StatefulWidget {
  @override
  //const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;
  @override
  State<newUser> createState() => _NewUserState();
}




class _NewUserState extends State<newUser> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
        appBar: AppBar(
          title: const Text("New User"),
          backgroundColor: Colors.greenAccent,
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.close), onPressed: () =>
            {
              Navigator.pop(context)
            })
          ],
        ),
        body: Center(
          child: Newuserwidget(),
        )

    ),
    );
  }
}



class Newuserwidget extends StatefulWidget {

  @override
  _addingUserState createState() => _addingUserState();
}

//Design of Buttons and Labels Below for direction
class _addingUserState extends State<Newuserwidget> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();

  //gender as it could differ
  bool male = false;
  //bool female = false;
  //bool n_b = false;
  //bool other = false;

  //take care of the exercise levels for heart rates
  bool no_ex = false;
  bool one_ex = false;
  bool two_ex = false;
  bool thfr_ex = false;
  bool five_ex =false;

  //again for smoking
  bool smoker = false;
  bool non_smoker= false;

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        TextFormField(
              controller: name_controller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Full Name',
              )
          ),
        TextFormField(
          controller: date_controller,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter DoB (dd-mm-yyyy)',
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            SizedBox(width: 10),
            Text('Male'),
            Checkbox(
              value: male,
              onChanged:(male){
                setState((){
                  this.male = male!;
                });
              },
            ),
            Text('Female'),
            Checkbox(
              value: male,
              onChanged:(male){
                setState((){
                  //this.female = female!;
                });
              },
            ),
            // Text('Non-Binary'),
            // Checkbox(
            //   value: n_b,
            //   onChanged:(n_b){
            //     setState((){
            //       this.n_b = n_b!;
            //     });
            //   },
            // ),
            // Text('Other'),
            // Checkbox(
            //   value: other,
            //   onChanged:(other){
            //     setState((){
            //       this.other = other!;
            //     });
            //   },
            // ),
          ]
        ),
        Text('Exercise per Week ', style: TextStyle(fontSize: 20)),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
              SizedBox(width: 10),
              Text('0'),
              Checkbox(
                value: no_ex,
                onChanged:(no_ex){
                  setState((){
                    this.no_ex = no_ex!;
                  });
                },
              ),
              Text('1'),
              Checkbox(
                value: one_ex,
                onChanged:(one_ex){
                  setState((){
                    this.one_ex = one_ex!;
                  });
                },
              ),
              Text('2'),
              Checkbox(
                value: two_ex,
                onChanged:(two_ex){
                  setState((){
                    this.two_ex = two_ex!;
                  });
                },
              ),
              Text('3-4'),
              Checkbox(
                value: thfr_ex,
                onChanged:(thfr_ex){
                  setState((){
                    this.thfr_ex = thfr_ex!;
                  });
                },
              ),
              Text('5+'),
              Checkbox(
                value: five_ex,
                onChanged:(five_ex){
                  setState((){
                    this.five_ex = five_ex!;
                  });
                },
              ),
            ]

        ),
        Text('Smoker?', style: TextStyle(fontSize:20)),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
              SizedBox(width: 10),
              Text('Yes'),
              Checkbox(
                value: smoker,
                onChanged:(smoker){
                  setState((){
                    this.smoker = smoker!;
                  });
                },
              ),
              Text('No'),
              Checkbox(
                value: non_smoker,
                onChanged:(non_smoker){
                  setState((){
                    this.non_smoker = non_smoker!;
                  });
                },
              ),
            ]

        ),
    ],
    );
  }
}



