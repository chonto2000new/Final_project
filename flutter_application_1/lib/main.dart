// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/second_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final controllerAmoung = TextEditingController();
  final controllerPercent = TextEditingController();
  double tip = 0;
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
      //separacion mas piola
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
      //separacion piola para saber que hago
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("Tips"),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(children: [
          TextField(
            controller: controllerAmoung,
            decoration: const InputDecoration(labelText: "Amount"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
          TextField(
            controller: controllerPercent,
            decoration: const InputDecoration(labelText: "Percent"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
          Text(
            ("Tip to pay \$$tip"),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          RaisedButton(
            child: const Text("Calculate"),
            color: Colors.purple,
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                double amount = double.parse(controllerAmoung.text);
                double percent = double.parse(controllerPercent.text);
                tip = amount * percent / 100;
                setDefaultValues(percent);
              });
            },
          ),
        ]),
      ),
    );
  }
}
