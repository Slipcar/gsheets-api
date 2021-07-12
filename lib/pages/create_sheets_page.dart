import 'package:clientes_inadimplentes_2/api/sheet/user_sheet_api.dart';
import 'package:clientes_inadimplentes_2/widgets/new_user_form_widget%20copy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateSheetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey[200],
    appBar: AppBar(
      title: Text('Cadastrar Cliente Inadimplente'),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,25,0),
          child: GestureDetector(
            child: Icon(
              Icons.edit,
              size: 35,
            ),
            onTap:() {
              Navigator.popAndPushNamed(
                context, '/modifyUser' 
              );
            }  
          ),
        ),
      ],
    ),
    body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(32),
      child: SingleChildScrollView(
        child: 
        NewUserForm(onSavedUser: (user) async{
          final id = await UserSheetApi.getRowCount() + 1;
          final newUser = user.copy(id: id);

          await UserSheetApi.insert([newUser.toJson()]);
        }),
      ),
    ),
  );
}