part of '../local_pub.dart';

class NoRecord extends StatelessWidget {
  final String? reason;
  final Widget? icon;

  const NoRecord({super.key, this.icon, this.onRefresh, this.reason});

  final AsyncCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return onRefresh == null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ??
                    Image.asset(
                      'assets/icons/not_found.png',
                      height: 160,
                      width: 160,
                    ),
                const SizedBox(height: 8),
                Text(reason ?? 'No Record Found',
                    style: CHIStyles.smSemiBoldStyle),
              ],
            ),
          )
        : RefreshIndicator(
            onRefresh: onRefresh!,
            child: Center(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon ??
                        Image.asset(
                          'assets/icons/not_found.png',
                          height: 160,
                          width: 160,
                        ),
                    const SizedBox(height: 8),
                    Text(reason ?? 'No Record Found',
                        style: CHIStyles.smSemiBoldStyle),
                  ],
                ),
              ),
            ));
  }
}
