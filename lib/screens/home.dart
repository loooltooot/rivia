import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rivia/res/bloc/rivia_bloc.dart';
import 'package:rivia/res/constants.dart';
import 'package:rivia/screens/encrypt_screen.dart';
import 'package:rivia/screens/settings_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isSlided = false;
  double _leftPadding = 20;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RiviaBloc(),
      child: Scaffold(
        backgroundColor: kBrightColor,
        body: Stack(
          children: [
            const Positioned(
              left: 20,
              child: SettingsScreen()
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  'catalin software© 2022',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: kDarkColor
                  )
                ),
              ),
            ),
            AnimatedPositioned(
              left: _leftPadding,
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: kDarkColor,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: kDarkColor,
                  //     blurRadius: 7,
                  //     spreadRadius: 3
                  //   )
                  // ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  )
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width - 90,
              top: 55,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 40,
                  color: _isSlided ? kDarkColor : kBrightColor,
                ),
                onPressed: () {
                  setState(() {
                    _isSlided ? _leftPadding = 20 :
                    _leftPadding = MediaQuery.of(context).size.width - 20;
                    _isSlided = !_isSlided;
                  });
                },
              ),
            ),
            AnimatedPositioned(
              left: _leftPadding,
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
              child: const EncryptScreen(),
            )
          ],
        ),
      ),
    );
  }
}
