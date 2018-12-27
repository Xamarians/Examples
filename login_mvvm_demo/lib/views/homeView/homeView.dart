import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/viewModels/loginViewModel.dart';

class HomeView extends StatelessWidget {
  HomeView(this.model);
  LoginViewModel model;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Screen"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Text("Welcome "+model.email.toString()),
            new RaisedButton(
              onPressed: model.logOut,
              child: new Text("LogOut"),
            )
          ],
        ),
      ),
    );
  }
}
