import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/routes/home/home.dart';

import 'routes/chat.dart';
import 'routes/account.dart';

class RootWidget extends StatefulWidget {
  RootWidget({Key key}) : super(key: key);

  @override
  RootWidgetState createState() => RootWidgetState();
}

class RootWidgetState extends State<RootWidget> {
  int selectedIndex = 0;
  final bottomNavigationBarItems = <BottomNavigationBarItem>[];

  // アイコン情報
  static const footerIcons = [
    Icons.home,
    Icons.textsms,
    Icons.account_circle,
  ];

  // アイコン文字列
  static const footerItemNames = [
    'ホーム',
    'トーク',
    'アカウント',
  ];

  var routes = [Home(), Chat(), Account()];

  @override
  void initState() {
    super.initState();
    bottomNavigationBarItems.add(activeState(0));
    for (var i = 1; i < footerItemNames.length; i++) {
      bottomNavigationBarItems.add(deactiveState(i));
    }
  }

  /// インデックスのアイテムをアクティベートする
  BottomNavigationBarItem activeState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          footerIcons[index],
          color: Colors.black87,
        ),
        title: Text(
          footerItemNames[index],
          style: TextStyle(
            color: Colors.black87,
          ),
        ));
  }

  /// インデックスのアイテムをディアクティベートする
  BottomNavigationBarItem deactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          footerIcons[index],
          color: Colors.black26,
        ),
        title: Text(
          footerItemNames[index],
          style: TextStyle(
            color: Colors.black26,
          ),
        ));
  }

  void onItemTapped(int index) {
    setState(() {
      bottomNavigationBarItems[selectedIndex] = deactiveState(selectedIndex);
      bottomNavigationBarItems[index] = activeState(index);
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: routes.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: bottomNavigationBarItems,
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ));
  }
}
