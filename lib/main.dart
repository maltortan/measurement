
import 'package:measurement/models/user.dart';
import 'package:flutter/material.dart';
import 'package:measurement/utils/Database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measurement Demo',
      home: Measurement(),
    );
  }
}

class Measurement extends StatefulWidget {
  @override
  MeasurementState createState() => MeasurementState();
}

class ItemData {
  var icon;
  var name;

  ItemData(IconData icon, String name) {
    this.icon = icon;
    this.name = name;
  }
}
// class TextBox extends TextField {
//   @override
//
// }
class MeasurementState extends State<Measurement> {
  var username;
  var password;
 Map<String, String> newUser = {};
 Future _userFuture;

 @override
 void initState(){
   super.initState();
   _userFuture = getUser();

 }
 getUser () async {
   print('User Data starts here');
   final _userData = await DBProvider.db.getUser();
   print('User Data is here'+_userData.toString());
   return _userData;
 }
  var list = [
    ItemData(Icons.ac_unit_sharp, 'Length'),
    ItemData(Icons.add_chart, 'Area'),
    ItemData(Icons.favorite_border_outlined, 'Volume'),
    ItemData(Icons.print, 'Mass')
  ];

  sendLists() {
    return list;
  }

  @override
  Widget build(BuildContext context) {
    void list() {
      Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (BuildContext measurecontext) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Other List Page'),
              ),
              body: FutureBuilder(
                future: _userFuture,
                builder: (_,userData) {
                  switch (userData.connectionState) {
                    case ConnectionState.none:
                      return Container(); // TODO: Handle this case.

                    case ConnectionState.waiting:
                      return Container(); // TODO: Handle this case.

                    case ConnectionState.active:
                      return Container(); // TODO: Handle this case.

                    case ConnectionState.done:
                      if (1==1) {
                        print(userData.data);
                        newUser = Map<String, String>.from(userData.data);
                        // TODO: Handle this case.
                        print('till here');
                      }
                      return
                        Center(
                            child: Column(
                                children: [
                                    Text(newUser['username']),
                                    Text(newUser['password']),
                                  Text('reached here'),
                                ]
                            ));
                  }
                  return Container();
                })
            );

          })


      );
    }


    return Scaffold(
        appBar: AppBar(
          title: Text('Measurement app'),

        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Column(
                    children: [
                      Text('Username'),
                      TextField(
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      }
                )
                    ],),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Column(
                    children: [
                      Text('Password'),
                      TextField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          }
                      )
                    ],),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 50),
                    child: FlatButton(
                      child: Text('Save'),
                      onPressed: (){
                        var newDBUser = User(username: username, password: password);
                        DBProvider.db.newUser(newDBUser);

                      },
                    )
                ),
                Container(
                    padding: EdgeInsets.only(bottom: 50),
                    child: FlatButton(
                      child: Text('List'),
                      onPressed: (){

                        list();
                      },
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}

// class ListIcon extends StatefulWidget {
//   @override
//   _ListIconState createState() => _ListIconState();
// }
//
// class _ListIconState extends State<ListIcon> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//     );
//   }
// }
//
