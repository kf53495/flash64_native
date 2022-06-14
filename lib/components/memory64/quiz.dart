import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'providers/stone_provider.dart';
import 'providers/button_visiblity_provider.dart';

class Memory64Quiz extends ConsumerWidget {
  const Memory64Quiz({
    Key? key,
    required this.boardSize,
  }) : super(key: key);
  final boardSize;

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
                          Visibility(
                            child: GestureDetector(
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
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: ref.watch(buttonVisiblityProvider).startButton,
              child: ElevatedButton(
                child: const Text('Start'),
                onPressed: () {
                  ref.read(stoneProvider.notifier).addStone();
                  ref.read(buttonVisiblityProvider.notifier).pushStartButton();
                },
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: ref.watch(buttonVisiblityProvider).memorizedButton,
              child: ElevatedButton(
                child: const Text('おぼえた！'),
                onPressed: () {
                  ref
                      .read(buttonVisiblityProvider.notifier)
                      .pushMemorizedButton();
                },
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: ref.watch(buttonVisiblityProvider).answerButton,
              child: ElevatedButton(
                child: const Text('Answer'),
                onPressed: () {
                  ref.read(buttonVisiblityProvider.notifier).pushAnswerButton();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class StoneColor extends ConsumerWidget {
  const StoneColor({
    Key? key,
    required this.verticalBox,
    required this.horizontalBox,
  }) : super(key: key);
  final int verticalBox;
  final int horizontalBox;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<StoneInformation> stoneColors = ref.watch(stoneProvider);
    if (stoneColors.isEmpty) {
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
          color: (stoneColors[masusitei(verticalBox, horizontalBox)].stoneColor)
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
