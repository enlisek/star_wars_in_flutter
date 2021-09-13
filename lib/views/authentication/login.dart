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

  String mail;
  String password;


  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor:Colors.grey[900],
      appBar: AppBar(
        // backgroundColor: Colors.yellow,
        elevation: 0,
        title: Text('Log in',
            style: TextStyle(
             color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold
        ),),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.account_box_outlined,color: Theme.of(context).accentColor,),
            onPressed:(){
              Navigator.pushReplacementNamed(context, '/register');
            },
            label: Text('Register',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).buttonColor)
            )
            ),
          ]
      ),
      body: Container(
        child:Padding(
            padding: EdgeInsets.all(16.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: TextStyle(
                            color: Theme.of(context).accentColor
                        ),
                        decoration:  InputDecoration(
                          icon: Icon(Icons.mail_outline, color: Theme.of(context).accentColor,),
                          labelText: 'Email *',
                          labelStyle:  TextStyle(
                              // color: Colors.yellow
                          ),
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
                        style: TextStyle(
                            color: Colors.yellow
                        ),
                        obscureText: true,
                        decoration:  InputDecoration(
                          focusedBorder: InputBorder.none,

                          icon: Icon(Icons.vpn_key,
                            color: Theme.of(context).accentColor,
                          ),
                          labelText: 'Password *',
                          labelStyle:  TextStyle(
                               // color: Colors.yellow
                          ),
                        ),
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val)=>val.length<8?'Password is too short':null ,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all(Theme.of(context).buttonColor),
                            elevation:MaterialStateProperty.all<double>(0),
                            shape:MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
                        child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child:Text('Log in',
                                style: TextStyle(
                                     color: Theme.of(context).accentColor,
                                    fontSize: 20))),
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
                      )),
                    ],
                  ),

                ),
                SizedBox(
                  width: double.infinity,
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context,'/main_view_model_without_account',arguments: 'people');
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).buttonColor),
                      elevation:MaterialStateProperty.all<double>(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child:Text('Try it now without account',
                        style: TextStyle(
                             color: Theme.of(context).accentColor,
                            fontSize: 20)
                  )
                  ),))

              ],
            ),




        ),
      ),
    );
  }
}
