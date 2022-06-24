import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GlobalAppBar extends HookWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  // のちに現在洗濯中のゲーム名が表示されるように設定すること
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('ぐろーばるあっぷばーです'),
    );
  }
}
