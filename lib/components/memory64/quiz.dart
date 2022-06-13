import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math';
import '../global_components/appbar.dart';

@immutable
class StoneInformation {
  const StoneInformation({
    required this.id,
    required this.stoneColor,
    required this.visiblity,
  });

  final int id;
  final bool stoneColor;
  final bool visiblity;

  StoneInformation copyWith({int? id, bool? stoneColor, bool? visiblity}) {
    return StoneInformation(
      id: id ?? this.id,
      stoneColor: stoneColor ?? this.stoneColor,
      visiblity: visiblity ?? this.visiblity,
    );
  }
}

class StoneNotifier extends StateNotifier<List<StoneInformation>> {
  StoneNotifier() : super([]);
  int placementId = 1;

  void addStone() {
    state = [
      ...state,
      StoneInformation(
        id: placementId,
        stoneColor: Random().nextBool(),
        visiblity: true,
      )
    ];
    placementId++;
  }
}

final stoneProvider =
    StateNotifierProvider<StoneNotifier, List<StoneInformation>>(
        (ref) => StoneNotifier());

class Memory64Quiz extends ConsumerWidget {
  const Memory64Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  for (int boardColumn = 0; boardColumn < 4; boardColumn++)
                    TableRow(
                      children: <Widget>[
                        for (int boardRow = 0; boardRow < 4; boardRow++)
                          GestureDetector(
                            onTap: () {},
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: FractionallySizedBox(
                                widthFactor: 0.85,
                                child: StoneColor(/*boardColumn, boardRow*/),
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
              onPressed: () {
                ref.read(stoneProvider.notifier).addStone();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StoneColor extends HookConsumerWidget {
  StoneColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<StoneInformation> stonesss = ref.watch(stoneProvider);

    if (stonesss.isEmpty) {
      return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (stonesss[0].stoneColor) ? Colors.black : Colors.white,
        ),
      );
    }
  }
}
