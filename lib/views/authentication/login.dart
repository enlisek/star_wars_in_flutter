import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_in_flutter/services/auth.dart';
import 'package:star_wars_in_flutter/views/authentication/register.dart';
import 'package:toast/toast.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final AuthService _authService= AuthService();

  String test1;

  String mail;
  String password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Log in',
            style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.account_box_outlined, color:Colors.yellow,),
            onPressed:(){
              Navigator.pushReplacementNamed(context, '/register');
            },
            label: Text('Register',style: TextStyle(color: Colors.yellow),),
          )
        ],
      ),
      body: Container(
        child:Padding(
            padding: EdgeInsets.all(16.0),

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.0,),
                  TextFormField(
                    style: TextStyle(color: Colors.yellow),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail_outline, color: Colors.yellow),
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

                      icon: Icon(Icons.vpn_key, color: Colors.yellow,),
                      labelText: 'Password *',
                      labelStyle:  TextStyle(color: Colors.yellow),
                    ),
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                    validator: (val)=>val.length<8?'Password is too short':null ,
                  ),
                  SizedBox(height: 20.0,),
                  ElevatedButton(
                    child: Text('Log in'),
                    onPressed: ()async{
                      if(_formKey.currentState.validate()){
                        dynamic res =await _authService.login( mail, password);
                        if(res==null){

                          Toast.show("Login unsuccessful", context, gravity: Toast.CENTER);

                        }
                        else{

                          _formKey.currentState?.reset();


                        }
                      }
                    },
                  )
                ],
              ),

            )


        ),
      ),
    );
  }
}
