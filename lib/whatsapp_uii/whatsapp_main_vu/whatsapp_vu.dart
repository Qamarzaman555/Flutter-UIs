import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';
import '../call_vu/calls_vu.dart';
import '../chat_vu/chats_vu.dart';
import '../group_vu/groups_vu.dart';
import '../updates_vu/updates_vu.dart';
import 'whatsapp_vm.dart';

class WhatsappVU extends StackedView<WhatsappVM> {
  const WhatsappVU({super.key});

  @override
  Widget builder(BuildContext context, WhatsappVM viewModel, Widget? child) {
    return DefaultTabController(
      length: 4,
      initialIndex: viewModel.initialIndex,
      child: Scaffold(
        appBar: customAppBar(context, viewModel),
        body: IndexedStack(
          index: viewModel.initialIndex,
          children: <Widget>[
            const GroupsVU(),
            ChatsVU(),
            const UpdatesVU(),
            const CallSVU()
          ],
        ),
      ),
    );
  }

  AppBar customAppBar(BuildContext context, WhatsappVM viewModel) {
    return AppBar(
      elevation: 2,
      backgroundColor: CHIStyles.darkSuccessColor,
      title: Text(
        'WhatsApp',
        style: CHIStyles.xlNormalStyle.copyWith(color: CHIStyles.whiteColor),
      ),
      actions: [
        appBarIconBtn(() {}, Icons.camera_alt_outlined),
        appBarIconBtn(() {}, Icons.search_outlined),
        appBarIconBtn(() {
          showPopupMenu(context, viewModel);
        }, Icons.more_vert)
      ],
      bottom: customTabBar(viewModel),
    );
  }

  TabBar customTabBar(WhatsappVM viewModel) {
    return TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white38,
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4,
      onTap: (value) {
        viewModel.onChangeTab(value);
      },
      tabs: const <Widget>[
        Tab(
          icon: Icon(
            Icons.group,
          ),
        ),
        Tab(
          text: 'Chats',
        ),
        Tab(text: 'updates'),
        Tab(
          text: 'Calls',
        ),
      ],
    );
  }

  Widget appBarIconBtn(Function()? onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: CHIStyles.whiteColor,
      ),
    );
  }

  showPopupMenu(BuildContext context, WhatsappVM viewModel) {
    showMenu<String>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      context: context,
      position: const RelativeRect.fromLTRB(8.0, 80.0, 0.0, 0.0),
      constraints: const BoxConstraints(minWidth: 220),
      items: viewModel.initialIndex == 1
          ? [
              const PopupMenuItem<String>(child: Text('New group')),
              const PopupMenuItem<String>(child: Text('New broadcast')),
              const PopupMenuItem<String>(child: Text('Linked devices')),
              const PopupMenuItem<String>(child: Text('Starred message')),
              const PopupMenuItem<String>(child: Text('Settings')),
            ]
          : [const PopupMenuItem<String>(child: Text('Settings'))],
      elevation: 8.0,
    );
  }

  @override
  WhatsappVM viewModelBuilder(BuildContext context) {
    return WhatsappVM();
  }
}
