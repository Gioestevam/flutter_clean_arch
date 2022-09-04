import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/login/login_cubit.dart';
import '../../components/button_submit_rectangular.dart';
import '../../components/custom_text_field_outlined.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = context.read<LoginCubit>();

    return ScaffoldMessenger(
      key: bloc.scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            width: size.width,
            height: size.height,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Colors.white,
                      fontSize: 70
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextFieldOutlined(
                    behaviorSubject: bloc.email,
                    label: 'E-mail',
                    validation: bloc.isEmailIsValid,
                  ),
                  SizedBox(height: 10),
                  CustomTextFieldOutlined(
                    behaviorSubject: bloc.password,
                    label: 'Senha',
                    isObscureText: true,
                    validation: (String text) {
                      if (text.isEmpty) {
                        bloc.password.sink.addError('Campo é obrigatório');
                      } else if (text.length < 6) {
                        bloc.password.sink.addError('Campo tem que ter no minimo maior ou igual a 6 caracteres.');
                      }
        
                      return null;
                    },
                    textInputAction: TextInputAction.done
                  ),
                  SizedBox(height: 30),
                  StreamBuilder(
                    stream: bloc.isButtonValid(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      bool isValid = snapshot.data ?? false;
                      return StreamBuilder(
                        stream: bloc.isLoading.stream,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          bool isLoading = snapshot.data ?? false;

                          return ButtonSubmitRectangular(
                            title: 'Entrar',
                            isLoading: isLoading,
                            onPress: isValid && !isLoading ? bloc.submit : null,
                          );
                        }
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
