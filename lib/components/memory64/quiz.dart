import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';

class Stones extends StateNotifier<List> {
  Stones() : super([]);
}

final stoneProvider = StateNotifierProvider<Stones, List>((ref) => Stones());

class Memory64Quiz extends StatelessWidget {
  const Memory64Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 23,
              height: 50,
              alignment: const Alignment(0, 0),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  for (int i = 0; i < 4; i++)
                    TableRow(
                      children: <Widget>[
                        for (int i = 0; i < 4; i++)
                          GestureDetector(
                            onTap: () {},
                            child: Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: FractionallySizedBox(
                                  widthFactor: 0.85,
                                  child: StoneColor(),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('おぼえた！'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class StoneColor extends StatelessWidget {
  StoneColor({Key? key}) : super(key: key);
  Map<String, String> stoneStates = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }
}
