import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/splash_cubit.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

}
