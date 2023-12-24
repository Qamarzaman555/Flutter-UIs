import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

class LinkTeleBankView extends StatelessWidget {
  const LinkTeleBankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text('Bank Name'),
          ),
          const CHITextField(
            fillColor: Colors.white,
            hintText: 'Telenor Microfinance Bank',
            borderRadius: 0,
            suffixIcon: Icon(Icons.lock),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              'Bank Account Number* ',
              style: CHIStyles.xsNormalStyle,
            ),
          ),
          const CHITextField(
            fillColor: Colors.white,
            borderRadius: 0,
            focusedBorderColor: Colors.white,
          ),
          20.spaceY,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: rowBtnsChoice(),
          ),
        ],
      ),
    );
  }

  Widget rowBtnsChoice() {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size(140.0, 50.0),
            backgroundColor: Colors.blue,
          ),
          onPressed: () {},
          child: Text(
            'NO',
            style: TextStyle(color: CHIStyles.whiteColor),
          ),
        ),
        20.spaceX,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size(140.0, 50.0),
            backgroundColor: Colors.grey,
          ),
          onPressed: () {},
          child: Text(
            'NEXT',
            style: TextStyle(color: CHIStyles.whiteColor),
          ),
        ),
      ],
    );
  }

  AppBar customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: CHIStyles.whiteColor,
        ),
      ),
      title: Text(
        'Link Telenor Microfinance Bank',
        style: CHIStyles.lgMediumStyle.copyWith(color: CHIStyles.whiteColor),
      ),
    );
  }
}
