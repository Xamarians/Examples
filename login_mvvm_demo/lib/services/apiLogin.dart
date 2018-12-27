import 'package:flutter_mvvm_demo/models/modelUser.dart';

class APILogin {
  Future<ModelLoginResponce> fetchUser(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return ModelLoginResponce(
        user: new ModelUser(
          age: 12,
          email: email,
          fName: "hello",
          lName: "john",
        ),
        error: null,
        isSuccess: true,
        statusCode: 200,
        authToken: "<Your Auth Token>");

    //  return ModelLoginResponce(
    //     error: "Invalid Username/Password",
    //     isSuccess: false,
    //   );
  }
}
