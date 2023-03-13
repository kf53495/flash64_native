import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GlobalAppBar extends HookWidget with PreferredSizeWidget {
  const GlobalAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  // のちに現在洗濯中のゲーム名が表示されるように設定すること
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('ぐろーばるあっぷばーです'),
    );
  }
}
