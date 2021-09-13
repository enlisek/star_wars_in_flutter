import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/auth.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _authService= AuthService();
  String test;
  String name;
  String mail;
  String password;
  String repeatedPassword;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // backgroundColor:  Colors.grey[900],
        appBar: AppBar(
          //backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text('Register', style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            ElevatedButton.icon(

              icon: Icon(Icons.account_box_outlined, color: Theme.of(context).accentColor,),
              onPressed:(){
                Navigator.pushReplacementNamed(context, '/login');
              },
              label: Text('Login',style: TextStyle(color: Theme.of(context).accentColor)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).buttonColor)
                )
            )
          ],

        ),
        body: Container(

          child:Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child:Column(
                  children: [

                    TextFormField(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      decoration:  InputDecoration(
                        icon: Icon(Icons.person, color: Theme.of(context).accentColor),
                        labelText: 'Name *',
                        // labelStyle:  TextStyle(color: Theme.of(context).accentColor),
                      ),
                      onChanged: (val){
                        setState(() {
                          name = val;
                        }
                        );
                      },
                      validator: (val)=>val.length>0?null:"Name is too short",
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      decoration:  InputDecoration(
                        icon: Icon(Icons.email_outlined, color: Theme.of(context).accentColor),
                        labelText: 'Email *',
                        // labelStyle:  TextStyle(color: Theme.of(context).accentColor),
                      ),
                      onChanged: (val){
                        setState(() {
                          mail = val;
                        }
                        );
                      },
                      validator: (val){
                        String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regExp = new RegExp(pattern);
                        return regExp.hasMatch(val)?null:'Email is incorrect';
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      obscureText: true,
                      decoration:  InputDecoration(
                          focusedBorder: InputBorder.none,
                          // labelStyle:  TextStyle(color: Theme.of(context).accentColor),
                          icon: Icon(Icons.vpn_key, color: Theme.of(context).accentColor,),
                          labelText: 'Password *'
                      ),
                      onChanged: (val){
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val){
                        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                        RegExp regExp = new RegExp(pattern);
                        return regExp.hasMatch(val)?null:'Password too weak';
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      obscureText: true,
                      decoration:  InputDecoration(
                          focusedBorder: InputBorder.none,
                          // labelStyle:  TextStyle(color: Theme.of(context).accentColor),
                          icon: Icon(Icons.vpn_key, color: Theme.of(context).accentColor,),
                          labelText: 'Repeat password *'
                      ),
                      onChanged: (val){
                        setState(() {
                          repeatedPassword = val;
                        });
                      },
                      validator: (val){
                        if(val == password) {
                          return null;
                        }
                        else {
                          return "Passwords don't match";
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                        child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).buttonColor),
                          elevation:MaterialStateProperty.all<double>(0),
                          shape:MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text('Register', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 20),),
                      )
                      ,
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          dynamic res =await _authService.register( mail, password,name);
                          if(res==null){
                            Toast.show("Register unsuccessful", context, gravity: Toast.CENTER);

                          }
                          else{
                            Toast.show("Register successful", context, gravity: Toast.CENTER);
                            _formKey.currentState?.reset();
                          }
                        }
                      },
                    )),

                  ],
                ),
              ),
            ),
          ),
        )



    );
  }
}
