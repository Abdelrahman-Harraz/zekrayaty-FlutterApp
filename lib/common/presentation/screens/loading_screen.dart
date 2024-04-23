import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/common/presentation/widgets/loading_widget.dart';
import 'package:zekrayaty_app/theme.dart';

// LoadingScreen widget
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnTheme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50.h,
            color: OwnTheme.backgroundColor,
            width: double.infinity,
            child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: Image.asset(
                  'assets/images/Logo1.png',
                  height: constraints.maxHeight * 0.5,
                ),
              );
            }),
          ),
          LoadingWidget(),
        ],
      ),
    );
  }
}
