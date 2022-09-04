import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/params/login_param.dart';
import '../../../../../core/services/navigator_service.dart';
import '../../../domain/usecase/login/login_usecase.dart';
import '../../components/snackbar.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  final LoginUsecase usecase;

  LoginCubit(this.usecase): super(Initial());

  final email = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();

  final isLoading = BehaviorSubject<bool>.seeded(false);
  
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  bool isValidEmail(String text) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
    ).hasMatch(text);
  }

  String? isEmailIsValid(String text) {
    if (text.isEmpty) {
      email.sink.addError('Campo é obrigatório');
    } else if (!isValidEmail(text)) {
      email.sink.addError('E-mail é inválido');
    }

    return null;
  }

  void submit() async {
    isLoading.sink.add(true);

    final LoginParam param = LoginParam(
      email: email.value,
      password: password.value
    );
    var response = await usecase.login(param);

    isLoading.sink.add(false);
    
    response.fold(
      (l) {
        if (l is UnauthorizedFailure) {
          SnackBarUtil.openSnackBarError(scaffoldMessengerKey,'Senha inválida');
        } else if (l is ServerFailure) {
          SnackBarUtil.openSnackBarError(
            scaffoldMessengerKey,
            'Ocorreu algum com o servidor, tente novamente mais tarde!'
          );
        } else if (l is NotFoundFailure) {
          SnackBarUtil.openSnackBarError(
            scaffoldMessengerKey,
            'Usuário não encontrado'
          );
        }
      },
      (r) => navigatorService.navigateToRoot('/home', null),
    );
  }

  Stream<bool> isButtonValid() {
    return CombineLatestStream.combine2(email, password, (email, password) {
      if (email != null && password != null) {
        return true;
      }

      return false;
    });
  }

}
