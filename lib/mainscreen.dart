import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:torch_light/torch_light.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  bool state = false;
  Future<void> Torchlighton() async {
    state = true;
    try {
      await TorchLight.enableTorch();
    } on EnableTorchExistentUserException catch (e) {
      print("Camera in use");
    } on EnableTorchNotAvailableException catch (e) {
      print("torch not avalibale");
    } on EnableTorchException catch (e) {
      print("Something went wrong");
    }
  }

  Future<void> Torchlightoff() async {
    try {
      state = false;

      await TorchLight.disableTorch();
    } on EnableTorchExistentUserException catch (e) {
      print("Camera in use");
    } on EnableTorchNotAvailableException catch (e) {
      print("Torch not availabe");
    } on EnableTorchException catch (e) {
      print("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 210, 242),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 75,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "Torch",
            style: GoogleFonts.aDLaMDisplay(
                color: Colors.red,
                fontSize: 50,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepPurple),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.deepPurple),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.2),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle, color: Colors.pink[200]),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-1.6, 1),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle, color: Colors.blue[200]),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90, bottom: 50),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: state == true
                      ? Image.asset("assets/torch.png")
                      : Image.asset("assets/torch2.png"),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: LiteRollingSwitch(
                      textOff: "Torch Off",
                      textOn: "Torch On",
                      textOnColor: Colors.white,
                      colorOff: Colors.red,
                      colorOn: Colors.amber,
                      iconOn: CupertinoIcons.lightbulb_fill,
                      iconOff: CupertinoIcons.lightbulb_slash,
                      onTap: () {},
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onChanged: (value) {
                        setState(() {
                          if (value) {
                            Torchlighton();
                          } else {
                            Torchlightoff();
                          }
                        });
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
