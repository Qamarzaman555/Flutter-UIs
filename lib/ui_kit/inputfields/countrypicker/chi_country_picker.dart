part of '../../local_pub.dart';

class CHICountryPicker extends StatefulWidget {
  final TextEditingController? controller;
  final bool mandatory;
  final CountryModel initialCountry;
  final String? hintText;
  final Function(String?)? onSaved;
  final bool enableBorder;
  final Color? fillColor;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Widget? suffixIcon;
  final String? heading;
  final Function(CountryModel) onGetCountry;

  /// CHI Country Picker which is made according the design of CHI RPM App.
  const CHICountryPicker({
    super.key,
    this.controller,
    this.hintText,
    this.mandatory = false,
    this.onSaved,
    this.fillColor,
    this.enableBorder = false,
    this.onEditingComplete,
    this.validator,
    this.initialValue,
    this.suffixIcon,
    this.heading,
    required this.onGetCountry,
    required this.initialCountry,
  });

  @override
  State<CHICountryPicker> createState() => _CHICountryPickerState();
}

class _CHICountryPickerState extends State<CHICountryPicker> {
  @override
  void initState() {
    selectedCountry = widget.initialCountry;
    _getCountries();
    super.initState();
  }

  final _searchController = TextEditingController();

  late CountryModel selectedCountry;
  List<CountryModel> countries = [];
  List<CountryModel> filteredCountries = [];

  void onCountrySelect(CountryModel country) {
    setState(() {
      selectedCountry = country;
    });
    widget.onGetCountry(country);
    _searchController.clear();
    filteredCountries.clear();
    Navigator.pop(context);
  }

  void _getCountries() {
    for (var c in countryJson) {
      countries.add(CountryModel.fromMap(c));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CHIIntegerField(
      controller: widget.controller,
      heading: widget.heading,
      hintText: widget.hintText,
      mandatory: widget.mandatory,
      onSaved: widget.onSaved,
      enableBorder: widget.enableBorder,
      fillColor: widget.fillColor,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onEditingComplete: widget.onEditingComplete,
      prefixIcon: _prefixIcon(),
      suffixIcon: widget.suffixIcon,
    );
  }

  Future<dynamic> _countryPickerBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Center(
                        child: Text('Select Country',
                            style: CHIStyles.mdNormalStyle)),
                  ),
                  _countrySearchField(setState),
                  Flexible(
                    child: _itemslistView(
                      filteredCountries.isEmpty ? countries : filteredCountries,
                      onTap: onCountrySelect,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _countrySearchField(StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: CHITextField(
        hintText: 'search',
        controller: _searchController,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
        onChanged: (p0) {
          setState(() {
            filteredCountries.clear();
            for (CountryModel i in countries) {
              final str =
                  "${i.countryName}${i.dialCode}${i.countryCode}".toLowerCase();
              if (str.contains(_searchController.text.toLowerCase().trim())) {
                filteredCountries.add(i);
              }
            }
          });
        },
      ),
    );
  }

  Widget _prefixIcon() {
    return InkWell(
        onTap: () {
          _countryPickerBottomSheet(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedCountry.dialCode!,
                style: CHIStyles.mdNormalStyle.copyWith(
                    color:
                        Theme.of(context).extension<CHITheme>()?.primaryColor),
              ),
              const SizedBox(width: 2),
              Text(selectedCountry.countryCode!,
                  style: CHIStyles.mdNormalStyle.copyWith(
                      color: Theme.of(context)
                          .extension<CHITheme>()
                          ?.primaryColor)),
              Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).extension<CHITheme>()?.primaryColor),
            ],
          ),
        ));
  }

  Widget _itemslistView(List<CountryModel> items,
      {required CountryCallBack onTap}) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final country = items[index];
          return Column(
            children: [
              CHICard(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                            "${country.dialCode} ${country.countryName} (${country.countryCode})",
                            style: CHIStyles.mdNormalStyle)),
                    selectedCountry == country
                        ? Icon(Icons.done,
                            color: Theme.of(context)
                                .extension<CHITheme>()
                                ?.primaryColor,
                            size: 20.0)
                        : const SizedBox.shrink(),
                  ],
                ),
                onTap: () => onTap(country),
              ),
              const SizedBox(height: 8),
            ],
          );
        });
  }
}

typedef CountryCallBack = void Function(CountryModel);
