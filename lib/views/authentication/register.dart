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

        backgroundColor:  Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text('Register', style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            ElevatedButton.icon(

              icon: Icon(Icons.account_box_outlined, color: Colors.yellow,),
              onPressed:(){
                Navigator.pushReplacementNamed(context, '/login');
              },
              label: Text('Login',style: TextStyle(color: Colors.yellow)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey[800])
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
                      style: TextStyle(color: Colors.yellow),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person, color: Colors.yellow),
                        labelText: 'Name *',
                        labelStyle:  TextStyle(color: Colors.yellow),
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
                      style: TextStyle(color: Colors.yellow),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email_outlined, color: Colors.yellow),
                        labelText: 'Email *',
                        labelStyle:  TextStyle(color: Colors.yellow),
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
                      style: TextStyle(color: Colors.yellow),
                      obscureText: true,
                      decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          labelStyle:  TextStyle(color: Colors.yellow),
                          icon: Icon(Icons.vpn_key, color: Colors.yellow,),
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
                      style: TextStyle(color: Colors.yellow),
                      obscureText: true,
                      decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          labelStyle:  TextStyle(color: Colors.yellow),
                          icon: Icon(Icons.vpn_key, color: Colors.yellow,),
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
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[800])),
                      child: Text('Register', style: TextStyle(color: Colors.yellow, fontSize: 20),),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        )



    );
  }
}
