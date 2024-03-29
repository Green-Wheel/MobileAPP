import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenwheel/services/backendServices/chat.dart';

class BottomBarWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;

  const BottomBarWidget(
      {required this.index, required this.onChangedTab, super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    const placeholder = Opacity(
      opacity: 0,
      child: IconButton(icon: Icon(Icons.no_cell), onPressed: null),
    );

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(
            index: 0,
            icon: const Icon(Icons.directions_car),
          ),
          placeholder,
          buildTabItem(
            index: 1,
            icon: const Icon(Icons.directions_bike),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({required int index, required Icon icon}) {
    final isSelected = index == widget.index;

    return IconTheme(
      data: IconThemeData(
        color: isSelected ? Colors.green : Colors.black,
      ),
      child: IconButton(
        icon: icon,
        onPressed: () {
          widget.onChangedTab(index);
        }
      ),
    );
  }
}

class BottomBarActionButton extends StatefulWidget {
  BottomBarActionButton({super.key});
  late int msgCount = 0;

  @override
  State<BottomBarActionButton> createState() => _BottomBarActionButtonState();
}

class _BottomBarActionButtonState extends State<BottomBarActionButton> {

  getUnreadMessages() async {
    int unreadMessages = await ChatService.getUnreadMessages();
    print("Mensajes por leer $unreadMessages");
    setState(() {
      widget.msgCount = unreadMessages;
    });
    print(widget.msgCount);
  }

  @override
  void initState() {
    super.initState();
    getUnreadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onPressed,
      backgroundColor: Colors.green,
      child: widget.msgCount > 0 ? notificationBadge() : const Icon(Icons.chat),
    );
  }

  void _onPressed() {
    GoRouter.of(context).go('/chats');
    //getUnreadMessages();
  }

  Widget notificationBadge() {
    return Badge(
      animationType: BadgeAnimationType.scale,
      position: BadgePosition.topEnd(top: -11, end: -11),
      badgeContent: Text(widget.msgCount.toString(),
          style: const TextStyle(color: Colors.white)),
      child: const Icon(Icons.chat),
    );
  }
}
