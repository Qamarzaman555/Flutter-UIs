part of '../local_pub.dart';

class ChatButton extends StatelessWidget {
  final VoidCallback? onTap;
  const ChatButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: FloatingActionButton(
        // elevation: 0,
        onPressed: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SvgPicture.asset('assets/icons/chat.svg'),
      ),
    );
  }
}
