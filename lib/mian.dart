// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(home: MyCustomUI()));
}

class MyCustomUI extends StatefulWidget {
  const MyCustomUI({super.key});

  @override
  _MyCustomUIState createState() => _MyCustomUIState();
}

class _MyCustomUIState extends State<MyCustomUI> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  bool _bool = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _animation1 = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _bool = true;
        }
      });
    _animation2 = Tween<double>(begin: 0, end: .3).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animation3 = Tween<double>(begin: .9, end: 1).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          splashColor: Colors.transparent,
          onPressed: () {
            if (_bool == true) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            _bool = false;
          },
        ),
      ),
      body: Stack(
        children: [
          // ALWAYS PLACE IT ON THE TOP OF EVERY WIDGET...
          BackgroundImage(),

          // EVERYTHING SHOULD BE HERE...
          SizedBox(
            height: height,
            width: width,
            child: null,
          ),

          // ALWAYS PLACE IT ON THE BOTTOM OF EVERY WIDGET...
          CustomNavigationDrawer(),
        ],
      ),
    );
  }

  Widget CustomNavigationDrawer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BackdropFilter(
      filter: ImageFilter.blur(
          sigmaY: _animation1.value, sigmaX: _animation1.value),
      child: Container(
        height: _bool ? 0 : height,
        width: _bool ? 0 : width,
        color: Colors.transparent,
        child: Center(
          child: Transform.scale(
            scale: _animation3.value,
            child: Container(
              width: width * .9,
              height: width * 1.3,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(_animation2.value),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black12,
                    radius: 35,
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: [
                      MyTile(Icons.settings_outlined, 'Settings', () {
                        HapticFeedback.lightImpact();
                        // Fluttertoast.showToast(
                        //   msg: 'Button pressed',
                        // );
                      }),
                      MyTile(Icons.info_outline_rounded, 'About', () {
                        HapticFeedback.lightImpact();
                        // Fluttertoast.showToast(
                        //   msg: 'Button pressed',
                        // );
                      }),
                      MyTile(Icons.feedback_outlined, 'Feedback', () {
                        HapticFeedback.lightImpact();
                        // Fluttertoast.showToast(
                        //   msg: 'Button pressed',
                        // );
                      }),
                      MyTile(Icons.find_in_page_outlined, 'Privacy Policy', () {
                        HapticFeedback.lightImpact();
                        // Fluttertoast.showToast(
                        //   msg: 'Button pressed',
                        // );
                      }),
                    ],
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget BackgroundImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/onboard/hamdhulla-shakeeb-bOBM8CB4ZC4-unsplash.jpg',
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget MyTile(
    IconData icon,
    String title,
    VoidCallback voidCallback,
  ) {
    return Column(
      children: [
        ListTile(
          tileColor: Colors.black.withOpacity(.08),
          leading: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          onTap: voidCallback,
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
          trailing: const Icon(
            Icons.arrow_right,
            color: Colors.white,
          ),
        ),
        divider()
      ],
    );
  }

  Widget divider() {
    return SizedBox(
      height: 5,
      width: MediaQuery.of(context).size.width,
    );
  }
}
