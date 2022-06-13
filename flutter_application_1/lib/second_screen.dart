// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final controllerPercent = TextEditingController();
  void setDefaultValues(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('percent', value);
  }

  Future<double?> getDefaultValues() async {
    final prefs = await SharedPreferences.getInstance();
    final double percent = prefs.getDouble('percent') ?? 15;

    return percent;
  }

  @override
  Widget build(BuildContext context) {
    getDefaultValues()
        .then((value) => {controllerPercent.text = value.toString()});
    return Scaffold(
        //drawer
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Screen1'),
                onTap: () {
                  final route =
                      MaterialPageRoute(builder: (context) => const MyApp());

                  Navigator.push(context, route);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Screen2'),
                onTap: () {
                  final route = MaterialPageRoute(
                      builder: (context) => const SecondScreen());

                  Navigator.push(context, route);
                },
              ),
            ],
          ),
        ),
        //termina drawer

        appBar: AppBar(
          title: const Text("This is my second screen"),
          backgroundColor: Colors.purple,
        ),
        body: Center(
            child: Column(children: [
          TextField(
            controller: controllerPercent,
            decoration: const InputDecoration(labelText: "Percent"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
          RaisedButton(
            color: Colors.purple,
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                double percent = double.parse(controllerPercent.text);

                setDefaultValues(percent);
              });
            },
            child: const Text("Save"),
          ),
        ])));
  }
}
