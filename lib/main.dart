import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
  }
  class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
  List _items = [];

  Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/menuler.json');
  final data = await json.decode(response);
  setState(() {
  _items = data["menus"][0]["items"];
  });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Kindacode.com',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Load Data'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                    children: [
                      ListTile(
                      leading: Image.asset(_items[index]["image"],width:50,height:50),
                      title: Text(_items[index]["name"]),
                      subtitle: Text(_items[index]["name"]),
                      onTap: () {
                        //Go to the next screen with Navigator.push
                      },
                    ),
                  ],
                    ),
                  );
                },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
  }