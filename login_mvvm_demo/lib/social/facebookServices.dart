import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_mvvm_demo/social/models/facebookUserModel.dart';
import 'package:http/http.dart' as http;

class FacebookServices {
  FacebookLogin facebookLogin = new FacebookLogin();
  var _profilefb;
  Future fetchFacebookUser() async {
    FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
        _profilefb = json.decode(graphResponse.body);
        return new FacebookUserModel(
          isSuccess: true,
          id: _profilefb["id"],
          name: _profilefb["name"],
          email: _profilefb["email"],
          firstName: _profilefb["first_name"],
          lasName: _profilefb["last_name"],
        );
        break;
      case FacebookLoginStatus.cancelledByUser:
        return new FacebookUserModel(
          isSuccess: false,
          error: "Facebook Login cancelled by User.",
        );
        break;
      case FacebookLoginStatus.error:
        return new FacebookUserModel(
          isSuccess: false,
          error: "Fatal facebook error.",
        );
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookLogin.logOut();
    print("Facebook user logged out");
  }
}
