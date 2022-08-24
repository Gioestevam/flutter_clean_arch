abstract class AuthenticationRepository {
    Future<void> login();
    Future<void> passwordReminder();
}