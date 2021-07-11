import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _CounterWidget(),
    );
  }
}

class _CounterWidget extends StatefulWidget {
  const _CounterWidget({Key? key}) : super(key: key);

  @override
  __CounterWidgetState createState() => __CounterWidgetState();
}

class __CounterWidgetState extends State<_CounterWidget> {
  String countString = "";
  String localCount = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: _incrementCounter, child: Text("Increment Counter")),
          ElevatedButton(onPressed: _getCounter, child: Text("Get Counter")),
          Text(
            countString,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "result: " + localCount,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
  _incrementCounter() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countString = countString + "1";
    });
    int counter = (prefs.getInt("counter")??0)+1;
    await prefs.setInt("counter", counter);
  }

  _getCounter()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = prefs.getInt("counter").toString();
    });

  }
}
