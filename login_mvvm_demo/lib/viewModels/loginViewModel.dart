import 'package:flutter_mvvm_demo/helpers/mySharedPrefrences.dart';
import 'package:flutter_mvvm_demo/models/modelUser.dart';
import 'package:flutter_mvvm_demo/services/apiLogin.dart';
import 'package:flutter_mvvm_demo/social/facebookServices.dart';
import 'package:flutter_mvvm_demo/social/googleServices.dart';
import 'package:flutter_mvvm_demo/social/models/facebookUserModel.dart';
import 'package:flutter_mvvm_demo/social/models/googleUserModel.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginViewModel extends Model {
  String email;
  String _password;
  String _error;
  bool _isLoading = false;
  bool isAuthenticated = false;
  bool _autoValidate = false;
  String authToken;
  APILogin _apiLogin = new APILogin();
  GoogleServices _googleServices = new GoogleServices();
  FacebookServices _facebookServices = new FacebookServices();
  LoginViewModel();
  LoginViewModel.ifAuth({this.authToken, this.isAuthenticated, this.email});

  bool get isLoading => _isLoading;
  bool get autoValidate => _autoValidate;
  String get error => _error;

  void saveEmail(String value) {
    email = value;
  }

  void savePassword(String value) {
    _password = value;
  }

  void updateAutovalidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  Future onEmailSubmit() async {
    _isLoading = true;
    notifyListeners();
    ModelLoginResponce result = await _apiLogin.fetchUser(email, _password);
    if (result.isSuccess) {
      isAuthenticated = true;
      _autoValidate = false;
      _error = "";
      MySharedPrefrences.setIsAuthenticated(true);
      MySharedPrefrences.setAuthToken(result.authToken);
      MySharedPrefrences.setUserEmail(result.user.email);
    } else {
      _error = result.error;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future onGoogleLogin() async {
    GoogleUserModel result = await _googleServices.fetchGoogleUser();
    if (result.isSuccess) {
      isAuthenticated = true;
      _autoValidate = false;
      email = result.email;
      MySharedPrefrences.setIsAuthenticated(true);
      MySharedPrefrences.setAuthToken(result.id);
      MySharedPrefrences.setUserEmail(result.email);
    } else {
      _error = result.error;
    }
    notifyListeners();
  }

  Future onFacebookLogin() async {
    FacebookUserModel result = await _facebookServices.fetchFacebookUser();
    if (result.isSuccess) {
      isAuthenticated = true;
      _autoValidate = false;
      email = email;
      MySharedPrefrences.setIsAuthenticated(true);
      MySharedPrefrences.setAuthToken(result.authToken);
      MySharedPrefrences.setUserEmail(result.email);
    } else {
      _error = result.error;
    }
    notifyListeners();
  }

  logOut() {
    isAuthenticated = false;
    _autoValidate = false;
    authToken = "";
    _error = "";
    MySharedPrefrences.setIsAuthenticated(false);
    MySharedPrefrences.setAuthToken("");
    notifyListeners();
  }
}
