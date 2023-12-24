part of '../local_pub.dart';

class CHIDialogs {
  static final CHIDialogs _instance = CHIDialogs();
  bool _isOpen = false;

  static showSuccessAlert(BuildContext context,
      {required String title,
      required String message,
      VoidCallback? onCancel,
      bool enableCancelButton = false,
      String? okButtonLabel,
      VoidCallback? onConfirm}) {
    return _instance._showCustomAlert(
      context,
      title: title,
      message: message,
      icon: 'assets/icons/success_icon.svg',
      okButtonLabel: okButtonLabel ?? 'Ok',
      onCancel: onCancel,
      enableCancelButton: enableCancelButton,
      onConfirm: onConfirm,
    );
  }

  static showWarningAlert(BuildContext context,
      {required String title,
      required String message,
      String? okButtonLabel,
      VoidCallback? onCancel,
      bool enableCancelButton = false,
      VoidCallback? onConfirm}) {
    return _instance._showCustomAlert(
      context,
      title: title,
      message: message,
      icon: 'assets/icons/warning_icon.svg',
      okButtonLabel: okButtonLabel ?? 'Ok',
      onCancel: onCancel,
      enableCancelButton: enableCancelButton,
      onConfirm: onConfirm,
    );
  }

  static showErrorAlert(
    BuildContext context, {
    required String title,
    required String message,
    String? okButtonLabel,
    VoidCallback? onCancel,
    bool enableCancelButton = false,
    VoidCallback? onConfirm,
  }) {
    return _instance._showCustomAlert(
      context,
      title: title,
      message: message,
      icon: 'assets/icons/error_icon.svg',
      okButtonLabel: okButtonLabel ?? 'Ok',
      okButtonColor: const Color(0xffF04438),
      onCancel: onCancel,
      enableCancelButton: enableCancelButton,
      onConfirm: onConfirm,
    );
  }

  static showFilterDialog(
    context, {
    String? title,
    required List<Filter> filterList,
    required Function(List<String>?) onApply,
    required VoidCallback onCancel,
  }) async {
    List<String> filters = [];
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          insetPadding: const EdgeInsets.all(12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          actionsPadding: const EdgeInsets.all(8),
          titlePadding: const EdgeInsets.all(16),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title ?? 'Filter',
              textAlign: TextAlign.center,
              style: CHIStyles.lgMediumStyle,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.shortestSide,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: filterList
                    .map((data) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CHICheckBoxTile(
                            value: data.isSelected,
                            child: Text(
                                data.label! == 'Un Remark'
                                    ? 'Normal'
                                    : data.label!,
                                style: CHIStyles.mdNormalStyle),
                            onChanged: (val) {
                              setState(() => data.isSelected = val!);
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: CHIButton(
                          lable: 'CANCEL',
                          backgroundColor: const Color(0xffF04438),
                          onTap: onCancel)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: CHIButton(
                          lable: 'APPLY',
                          onTap: () {
                            filters.clear();
                            for (var f in filterList) {
                              if (f.isSelected) {
                                filters.add(f.label!);
                              }
                            }
                            onApply(filters);
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showCustomAlert(
    context, {
    required String title,
    required String message,
    required String icon,
    bool enableCancelButton = false,
    Color? okButtonColor,
    String okButtonLabel = 'Ok',
    String cancelButtonLabel = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    if (!_instance._isOpen) {
      _instance._isOpen = true;
      showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async {
            _instance._isOpen = false;
            return true;
          },
          child: AlertDialog(
            // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: const EdgeInsets.all(16),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(icon, fit: BoxFit.scaleDown),
                const SizedBox(height: 16),
                Text(title,
                    textAlign: TextAlign.center,
                    style: CHIStyles.lgMediumStyle),
              ],
            ),
            content: Builder(builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.shortestSide,
                child: Text(message,
                    textAlign: TextAlign.center,
                    style: CHIStyles.smNormalStyle
                        .copyWith(color: const Color(0xff667085))),
              );
            }),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CHIButton(
                  lable: okButtonLabel,
                  backgroundColor: okButtonColor,
                  onTap: onConfirm == null
                      ? () {
                          _instance._isOpen = false;
                        }
                      : () {
                          _instance._isOpen = false;
                          onConfirm();
                        },
                ),
              ),
              SizedBox(height: enableCancelButton ? 12 : 16),
              Visibility(
                visible: enableCancelButton,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CHIButton(
                    lable: cancelButtonLabel,
                    // foregroundColor: CHIStyles.primaryTextColor,
                    backgroundColor:
                        Theme.of(context).extension<CHITheme>()?.secondryColor,
                    onTap: onCancel == null
                        ? () {
                            _instance._isOpen = false;
                          }
                        : () {
                            _instance._isOpen = false;
                            onCancel();
                          },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      debugPrint('Dialog Already Open');
    }
  }

  static showProgress(BuildContext context,
      {String title = 'Loading please wait'}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 13, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Filter {
  String? label;
  bool isSelected;

  Filter({this.label, this.isSelected = false});
}
