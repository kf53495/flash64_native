import 'package:flutter/material.dart';
import 'quiz.dart';

class Memory64Selection extends StatelessWidget {
  const Memory64Selection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    builder: (context) => Memory64Quiz(),
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
