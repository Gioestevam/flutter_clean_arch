abstract class RemoteDataSource {
    Future<void> auth();
    Future<void> passwordReminder();
}