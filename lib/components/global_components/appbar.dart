import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flash64_native/components/home.dart';
import 'package:flash64_native/components/users/providers/user_input.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlobalAppBar extends HookWidget with PreferredSizeWidget {
  const GlobalAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  // のちに現在洗濯中のゲーム名が表示されるように設定すること
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('ぐろーばるあっぷばーです'),
    );
  }
}
