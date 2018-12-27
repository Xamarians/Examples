class FacebookUserModel {
  FacebookUserModel(
      {this.firstName,
      this.id,
      this.error,
      this.authToken,
      this.isSuccess,
      this.lasName,
      this.email,
      this.name});
  final String error;
  final String authToken;
  final String name;
  final String email;
  final String firstName;
  final String lasName;
  final String id;
  final bool isSuccess;

}
