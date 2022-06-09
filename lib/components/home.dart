import 'package:flutter/material.dart';
import 'global_components/appbar.dart';
import 'memory64/selection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      body: Column(
        children: [
          Container(
            width: 100,
            height: 50,
            child: Placeholder(
              color: Colors.blueAccent,
            ),
          ),
          Container(
            width: 100,
            height: 50,
            child: Placeholder(
              color: Colors.blueAccent,
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('デザイン練習へ'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Memory64Selection(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
