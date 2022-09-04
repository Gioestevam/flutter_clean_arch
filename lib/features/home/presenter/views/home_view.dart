import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: bloc.logout,
            icon: Icon(Icons.output)
          )
        ],
      ),
      body: Container(),
    );
  }

}
