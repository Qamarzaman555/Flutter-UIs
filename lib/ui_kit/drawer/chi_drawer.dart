part of '../local_pub.dart';

class CHIDrawer extends StatelessWidget {
  final Color? backgroundColor;
  final double? elevation;
  final Widget? accountHeader;
  final List<Widget>? actions;
  final Widget companyLogo;

  /// Customized Drawer with less code and simple to use
  const CHIDrawer({
    super.key,
    this.backgroundColor,
    this.elevation,
    this.actions,
    required this.companyLogo,
    this.accountHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      elevation: elevation,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              companyLogo,
              accountHeader ?? const SizedBox(),
              ...actions ?? [],
            ],
          ),
        ),
      ),
    );
  }
}

class CHIDrawerActionTile extends StatelessWidget {
  final String icon;
  final String lable;
  final VoidCallback? onTap;

  const CHIDrawerActionTile(
      {super.key, required this.icon, required this.lable, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SvgPicture.asset(icon,
                    fit: BoxFit.scaleDown, color: const Color(0xff667085)),
                const SizedBox(width: 12),
                Text(
                  lable,
                  style: CHIStyles.smMediumStyle
                      .copyWith(color: const Color(0xff667085)),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        Divider(color: Colors.grey[400], thickness: 0.3)
      ],
    );
  }
}

class CHIDrawerAccountHeader extends StatelessWidget {
  final String accountname;
  final String description;
  final String? image;

  /// Customized account header for CHI Drawer.This is the most uppser section of CHI Drawer.
  const CHIDrawerAccountHeader({
    super.key,
    required this.accountname,
    required this.description,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                Theme.of(context).extension<CHITheme>()?.primaryLightColor,
            radius: 38,
            child: SvgPicture.asset(
              image ?? 'assets/drawer/profile.svg',
              color: Theme.of(context).extension<CHITheme>()?.primaryColor,
              height: 35,
              width: 35,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(accountname, style: CHIStyles.xlMediumStyle, maxLines: 2),
                Text(
                  description,
                  style:
                      CHIStyles.mdNormalStyle.copyWith(color: Colors.grey[400]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
