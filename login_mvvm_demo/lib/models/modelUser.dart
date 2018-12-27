class ModelUser {
  ModelUser({this.email, this.fName, this.lName, this.age});
  String email;
  String fName;
  String lName;
  int age;
}

class ModelLoginResponce {
  ModelLoginResponce(
      {this.user, this.error, this.isSuccess, this.statusCode, this.authToken});
  ModelUser user;
  bool isSuccess;
  String error;
  String authToken;
  int statusCode;
}
