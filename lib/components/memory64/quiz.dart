import 'package:flash64_native/components/memory64/providers/board_size.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'providers/stone_provider.dart';
import 'providers/button_visiblity_provider.dart';

class Memory64Quiz extends ConsumerWidget {
  const Memory64Quiz({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int boardSize = ref.watch(boardSizeProvider);

    var buttonVisiblities = ref.watch(buttonVisiblityProvider);
    final readStoneProvider = ref.read(stoneProvider.notifier);
    final readButtonProvider = ref.read(buttonVisiblityProvider.notifier);
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
                  for (int verticalBox = 0;
                      verticalBox < boardSize;
                      verticalBox++)
                    TableRow(
                      children: <Widget>[
                        for (int horizontalBox = 0;
                            horizontalBox < boardSize;
                            horizontalBox++)
                          Visibility(
                            child: GestureDetector(
                              onTap: () {
                                if (ref
                                    .read(buttonVisiblityProvider)
                                    .answerButton) {
                                  readStoneProvider.hidestone(
                                    _calcStoneId(
                                      verticalBox,
                                      horizontalBox,
                                      boardSize,
                                    ),
                                  );
                                }
                              },
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
              visible: buttonVisiblities.startButton,
              child: ElevatedButton(
                child: const Text('Start'),
                onPressed: () {
                  readStoneProvider.displayAllStones();
                  readButtonProvider.pushStartButton();
                },
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: buttonVisiblities.memorizedButton,
              child: ElevatedButton(
                child: const Text('おぼえた！'),
                onPressed: () {
                  readButtonProvider.pushMemorizedButton();
                  readStoneProvider.hideAllStones();
                },
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: buttonVisiblities.answerButton,
              child: ElevatedButton(
                child: const Text('Answer'),
                onPressed: () {
                  readButtonProvider.pushAnswerButton();
                  readStoneProvider.displayAllStones();
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
    final int boardSize = ref.watch(boardSizeProvider);
    final int stoneId = _calcStoneId(verticalBox, horizontalBox, boardSize);
    if (stoneColors[stoneId].visiblity) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              (stoneColors[(stoneId)].stoneColor) ? Colors.black : Colors.white,
        ),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.lightGreen,
        ),
      );
    }
  }
}

int _calcStoneId(vertical, horizontal, boardSize) {
  int specifiedBox = (vertical) + (horizontal * boardSize);
  return specifiedBox;
}
