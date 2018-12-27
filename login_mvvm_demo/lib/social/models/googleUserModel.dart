class GoogleUserModel {
  GoogleUserModel(
      {this.error,
      this.isSuccess,
      this.firstName,
      this.lastName,
      this.photoUrl,
      this.email,
      this.id,
      this.token});

  final String error;
  final String token;
  final String email;
  final String firstName;
  final String lastName;
  final String photoUrl;
  final String id;
  final bool isSuccess;
}
