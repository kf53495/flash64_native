import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';

class StoneInformation {
  const StoneInformation(
      {required this.id, required this.stoneColor, required this.visiblity});

  final String id;
  final String stoneColor;
  final bool visiblity;

  StoneInformation copyWith({String? id, String? stoneColor, bool? visiblity}) {
    return StoneInformation(
      id: id ?? this.id,
      stoneColor: stoneColor ?? this.stoneColor,
      visiblity: visiblity ?? this.visiblity,
    );
  }
}

class StoneNotifier extends StateNotifier<List<StoneInformation>> {
  StoneNotifier() : super([]);

  void addStone(StoneInformation stoneInformation) {
    state = [...state, stoneInformation];
  }
}

final stoneProvider =
    StateNotifierProvider<StoneNotifier, List<StoneInformation>>(
        (ref) => StoneNotifier());

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
                columnWidths: const <int, TableColumnWidth>{
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

class StoneColor extends ConsumerWidget {
  StoneColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<StoneInformation> stonesss = ref.watch(stoneProvider);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }
}
