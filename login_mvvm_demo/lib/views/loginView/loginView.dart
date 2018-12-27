import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/helpers/loginHelper.dart';
import 'package:flutter_mvvm_demo/resources/strings.dart';
import 'package:flutter_mvvm_demo/viewModels/loginViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginView extends StatelessWidget {
  LoginView(this.loginModel);
  final LoginViewModel loginModel;
  static GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new ScopedModel(
      model: loginModel,
      child: new Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: new AppBar(
          title: new Text(Strings.loginPageTitle),
        ),
        body: new ScopedModelDescendant<LoginViewModel>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            } else {
              return new Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: new Form(
                  key: _loginFormKey,
                  autovalidate: false,
                  child: _buildLoginForm(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return new ScopedModelDescendant<LoginViewModel>(
      builder: (context, child, model) {
        return new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                errorMaxLines: 2,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: LoginHelper.validateEmail,
              autovalidate: model.autoValidate,
              onSaved: model.saveEmail,
            ),
            new TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.vpn_key),
                errorStyle: new TextStyle(fontSize: 10.0),
                errorMaxLines: 3,
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: LoginHelper.validatePassword,
              autovalidate: model.autoValidate,
              onSaved: model.savePassword,
            ),
            model.error == null || model.error.isEmpty
                ? new Container()
                : new Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: new Text(
                      model.error,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
            _submitButton(),
            _socialLogin(),
          ],
        );
      },
    );
  }

  Widget _submitButton() {
    return new Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: RaisedButton(
          shape: StadiumBorder(),
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          color: Colors.white,
          onPressed: () async {
            if (_loginFormKey.currentState.validate()) {
              _loginFormKey.currentState.save();
              await loginModel.onEmailSubmit();
              loginModel.updateAutovalidate(false);
            } else {
              loginModel.updateAutovalidate(true);
            }
          }),
    );
  }

  Widget _socialLogin() {
    return new Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton.icon(
            icon: new Image.asset(
              "assets/google.png",
              fit: BoxFit.scaleDown,
              height: 30.0,
              width: 30.0,
            ),
            shape: StadiumBorder(),
            label: Text(
              'Google',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            color: Colors.white,
            onPressed: loginModel.onGoogleLogin,
          ),
          RaisedButton.icon(
            icon: new Image.asset(
              "assets/facebook.jpg",
              fit: BoxFit.scaleDown,
              height: 30.0,
              width: 30.0,
            ),
            shape: StadiumBorder(),
            label: Text(
              'Facebook',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            color: Colors.white,
            onPressed: loginModel.onFacebookLogin,
          )
        ],
      ),
    );
  }
}
