import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    for (int i = 0; i < 16; i++) {
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
                  for (int verticalBox = 0; verticalBox < 4; verticalBox++)
                    TableRow(
                      children: <Widget>[
                        for (int horizontalBox = 0;
                            horizontalBox < 4;
                            horizontalBox++)
                          GestureDetector(
                            onTap: () {},
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                color: Colors.lightGreen,
                                child: FractionallySizedBox(
                                  widthFactor: 0.85,
                                  child: StoneColor(
                                    verticalBox: verticalBox,
                                    horizontalBox: horizontalBox,
                                  ),
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
            child: Visibility(
              visible: true,
              child: ElevatedButton(
                child: const Text('おぼえた！'),
                onPressed: () {
                  ref.read(stoneProvider.notifier).addStone();
                },
              ),
            ),
          ),
          const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Placeholder(),
            ),
          )
        ],
      ),
    );
  }
}

class StoneColor extends ConsumerWidget {
  StoneColor({
    Key? key,
    required this.verticalBox,
    required this.horizontalBox,
  }) : super(key: key);
  int verticalBox;
  int horizontalBox;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<StoneInformation> stonesss = ref.watch(stoneProvider);
    if (stonesss.isEmpty) {
      return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.lightGreen,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (stonesss[masusitei(verticalBox, horizontalBox)].stoneColor)
              ? Colors.black
              : Colors.red,
        ),
      );
    }
  }

  int masusitei(vertical, horizontal) {
    int specifiedBox = (vertical) + (horizontal * 4); //4は盤面サイズなのでのちに変数に置き換える
    return specifiedBox;
  }
}
