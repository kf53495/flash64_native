import 'package:flash64_native/components/global_components/firebase.dart';
import 'package:flash64_native/components/memory64/providers/board_size.dart';
import 'package:flash64_native/components/memory64/providers/quiz_mode.dart';
import 'package:flash64_native/components/memory64/providers/select_stone.dart';
import 'package:flash64_native/components/memory64/providers/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final uid = ref.watch(currentUserProvider);
    final int boardSize = ref.watch(boardSizeProvider);
    var buttonVisiblities = ref.watch(buttonVisiblityProvider);
    final int time = int.parse(ref.watch(timeProvider));
    bool veri = ref.read(correctCountProvider) == boardSize * boardSize;
    final readStoneProvider = ref.read(stoneProvider.notifier);
    final readButtonProvider = ref.read(buttonVisiblityProvider.notifier);
    final List<StoneInformation> boxColors = ref.watch(stoneProvider);

    return Scaffold(
      appBar: const GlobalAppBar(),
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
                          GestureDetector(
                            onTap: () {
                              if (ref
                                  .read(buttonVisiblityProvider)
                                  .answerButton) {
                                readStoneProvider.displayStone(
                                  ref.read(quizModeProvider),
                                  ref
                                      .read(selectStoneProvider.notifier)
                                      .selectedStone(),
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
                                color: boxColors[_calcStoneId(
                                  verticalBox,
                                  horizontalBox,
                                  boardSize,
                                )]
                                    .boxColor,
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
              visible: buttonVisiblities.startButton,
              child: ElevatedButton(
                child: const Text('Start'),
                onPressed: () {
                  readButtonProvider.pushStartButton();
                  readStoneProvider.displayAllStones();
                  readButtonProvider.startTimer(time);
                  readStoneProvider.hideAllStonesWithTimer(
                      ref.read(quizModeProvider), time);
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
                  readStoneProvider.hideAllStones(ref.read(quizModeProvider));
                },
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: buttonVisiblities.answerButton,
              child: ElevatedButton(
                child: const Text('Answer'),
                onPressed: () async {
                  readButtonProvider.pushAnswerButton();
                  readStoneProvider.displayResult();
                  await answerProcess(ref.read(quizModeProvider), uid,
                      ref.read(timeProvider), veri, boardSize);
                  ref.read(retryButtonProvider.notifier).state = true;
                },
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: true,
              child: Row(
                children: [
                  const SizedBox(
                    child: Text('正解数: '),
                  ),
                  Center(
                    child: Text(
                        '${ref.watch(correctCountProvider)} / ${boardSize * boardSize}'),
                  ),
                  Center(
                    child: Text(' ${ref.watch(quizModeProvider)}'),
                  ),
                ],
              ),
            ),
          ),
          if (ref.watch(retryButtonProvider))
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(retryButtonProvider.notifier).state = false;
                  readStoneProvider.initStones(
                      boardSize * boardSize, ref.read(quizModeProvider));
                  readButtonProvider.pushRetryButton();
                },
                child: const Text('リトライ'),
              ),
            ),
          Visibility(
            visible: _includeEmpty(ref.watch(quizModeProvider)),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(right: 30, left: 30),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(selectStoneProvider.notifier).selectBlack();
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ref.watch(selectStoneProvider).black
                                ? Colors.amber
                                : Colors.white,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ref.read(selectStoneProvider.notifier).selectWhite();
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ref.watch(selectStoneProvider).white
                                ? Colors.amber
                                : Colors.white,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
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
      if (stoneColors[(stoneId)].stoneColor == 'black') {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        );
      } else if (stoneColors[(stoneId)].stoneColor == 'white') {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        );
      } else {
        return const Visibility(
          visible: false,
          child: SizedBox(),
        );
      }
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

bool _includeEmpty(mode) {
  if (mode == 'empty') {
    return true;
  } else {
    return false;
  }
}

// FireStoreに保存する記述
Future<void> answerProcess(String mode, String? uid, String timeLimit,
    bool verification, int boardSize) async {
  try {
    if (uid != null) {
      await db
          .doc(uid)
          .collection('memory64')
          .doc(mode)
          .collection((boardSize * boardSize).toString())
          .doc(timeLimit)
          .set(
        {
          'challenge': FieldValue.increment(1),
        },
        SetOptions(merge: true),
      );
      if (verification) {
        await db
            .doc(uid)
            .collection('memory64')
            .doc(mode)
            .collection((boardSize * boardSize).toString())
            .doc(timeLimit)
            .set(
          {
            'clear': FieldValue.increment(1),
          },
          SetOptions(merge: true),
        );
      }
    }
    if (uid == null) {
      debugPrint('ログアウト中');
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
