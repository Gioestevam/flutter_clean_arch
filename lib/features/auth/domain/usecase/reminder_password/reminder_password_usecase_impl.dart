import 'package:injectable/injectable.dart';

import 'reminder_password_usecase.dart';

@LazySingleton(as: ReminderPasswordUseCase)
class ReminderPasswordUseCaseImpl implements ReminderPasswordUseCase {
  @override
  Future<void> reminderPassword() {
    throw UnimplementedError();
  }
}
