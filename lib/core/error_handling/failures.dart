class Failure {
  final String message;

  const Failure([this.message = "An Unknown error occur"]);

  factory Failure.code(String code) {
    switch (code) {
      case 'weak-password':
        return Failure('please enter a stronger password');
      case 'ivalid-email':
        return Failure('email is not valid');
      case 'email-already-used':
        return Failure('email exist already');
      case 'operation-not-allowed':
        return Failure('please contact support');
      case 'user-disabled':
        return Failure('this user is disabled');
      default:
        return Failure();
    }
  }
}
