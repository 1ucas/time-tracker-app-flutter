import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/account/ui/account_page.dart';
import 'package:time_tracker_flutter/app/home/domain/models/tab_item.dart';
import 'package:time_tracker_flutter/app/home/ui/cupertino_home_scaffold.dart';
import 'package:time_tracker_flutter/app/jobs/ui/jobs_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentTab = TabItem.jobs;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (_) => Container(),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem item) {
    if (item == _currentTab) {
      navigatorKeys[item].currentState.popUntil((route) => route.isFirst);
    } else {
    setState(() {
      _currentTab = item;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await navigatorKeys[_currentTab].currentState.maybePop();
      },
      child: CupertinoHomeScaffold(
        navigatorKeys: navigatorKeys,
        widgetBuilders: widgetBuilders,
        currentTab: _currentTab,
        onSelectTab: _select,
      ),
    );
  }
}
