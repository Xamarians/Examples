import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/helpers/mySharedPrefrences.dart';
import 'package:flutter_mvvm_demo/viewModels/loginViewModel.dart';
import 'package:flutter_mvvm_demo/views/homeView/homeView.dart';
import 'package:flutter_mvvm_demo/views/loginView/loginView.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  bool _isAuthenticated = await MySharedPrefrences.getIsAuthenticated();
  String _authToken = await MySharedPrefrences.getAuthToken();
  String _email =await MySharedPrefrences.getUserEmail();
  LoginViewModel loginModel;
  if (_isAuthenticated) {
    loginModel = new LoginViewModel.ifAuth(
        authToken: _authToken, isAuthenticated: _isAuthenticated,email: _email);
  } else {
    loginModel = new LoginViewModel();
  }

  runApp(new ScopedModel(
    model: loginModel,
    child: new MaterialApp(
        home: new ScopedModelDescendant<LoginViewModel>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        if (model.isAuthenticated) {
          return new HomeView(loginModel);
        } else {
          return LoginView(model);
        }
      },
    )),
  ));
}
