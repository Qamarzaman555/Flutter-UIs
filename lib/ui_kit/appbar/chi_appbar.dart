//ignore: must_be_immutable
part of '../local_pub.dart';

class CHIAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool addBackButton;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onBackPress;
  final bool search;
  final Color? color;
  final Widget? searchWidget;
  final bool showWelcome;

  const CHIAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBackPress,
    this.showWelcome = false,
    this.leading,
    this.addBackButton = true,
    this.search = false,
    this.searchWidget,
    this.color,
  });

  @override
  State<CHIAppBar> createState() => _CHIAppBarState();

  @override
  Size get preferredSize => const Size(64, 64);
}

class _CHIAppBarState extends State<CHIAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: widget.search
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: widget.searchWidget ?? const SizedBox(),
            )
          : Container(
              color: widget.color,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.leading ??
                      (widget.addBackButton
                          ? CHIActionButton(
                              //icon: 'assets/icons/arrow.svg',
                              onTap: widget.onBackPress ??
                                  () => Navigator.pop(context),
                              child:
                                  const Icon(Icons.arrow_back_ios_new_rounded),
                            )
                          : const SizedBox()),
                  widget.showWelcome
                      ? Expanded(
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  text: 'Welcome ',
                                  style: CHIStyles.smNormalStyle,
                                  children: [
                                    TextSpan(
                                      text: widget.title,
                                      style: CHIStyles.xlMediumStyle,
                                    )
                                  ])),
                        )
                      : Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: widget.title.length > 28 ? 8.0 : 0),
                            child: Text(widget.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CHIStyles.mdSemiBoldStyle),
                          ),
                        ),
                  Row(children: widget.actions ?? [const SizedBox()])
                ],
              ),
            ),
    );
  }
}
