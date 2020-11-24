import 'package:flutter/material.dart';

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
class ItemData{
  var icon;
  var name;
  ItemData(IconData icon,String name){
          this.icon= icon;
          this.name= name;
  }
}
class MeasurementState extends State<Measurement> {
  var list = [ItemData(Icons.ac_unit_sharp,'Length'),ItemData(Icons.add_chart, 'Area'),
    ItemData(Icons.favorite_border_outlined,'Volume'),ItemData(Icons.print,'Mass')];
  sendLists() {
    return list;
  }

  @override
  Widget build(BuildContext context) {

    var unittype;
    var values=sendLists();
    return Scaffold(
        appBar: AppBar(
          title: Text('Measurement app'),

        ),
        body: ListView.builder(
            itemCount: values.length,
            itemBuilder: (context,i){
  final ItemData listItem= values[i];
          return ListTile(
              leading:Icon(listItem.icon,size: 50,),
              title: Text(listItem.name),
              contentPadding: EdgeInsets.all(80.0),

            );
        })
    );
  }
}
