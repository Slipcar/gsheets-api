import 'package:clientes_inadimplentes_2/api/sheet/user_sheet_api.dart';
import 'package:clientes_inadimplentes_2/main.dart';
import 'package:clientes_inadimplentes_2/model/user.dart';
import 'package:clientes_inadimplentes_2/widgets/button_widget.dart';
import 'package:clientes_inadimplentes_2/widgets/navigate_users_widget.dart';
import 'package:clientes_inadimplentes_2/widgets/user_form_widget.dart';
import 'package:flutter/material.dart';

class ModifySheetPage extends StatefulWidget {
  const ModifySheetPage({ Key? key }) : super(key: key);

  @override
  _ModifySheetPageState createState() => _ModifySheetPageState();
}

class _ModifySheetPageState extends State<ModifySheetPage> {
  List<User> users = [];
  List<User> currentUsers = [];
  int index = 0;
  
  @override
  void initState() {
    super.initState();
    
    getUsers();
  }
  
  getUsers({int index = 0}) async {
    
    final users = await UserSheetApi.getAll();

    for (var user in users) {
      if (user.cobrado == 'N') {
        currentUsers.add(user);
      }
    }
    
    setState(() {
      this.users = currentUsers;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey[200],
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: Text(MyApp.title),
      centerTitle: true,
      ///leading: GestureDetector(
      //   child: Icon(
      //     Icons.list, 
      //     size: 35,
      //   ),
      //   onTap: () => Navigator.popAndPushNamed(context, '/ListAllUser'),
      // ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,18,0),
          child: GestureDetector(
            child: Icon(
              Icons.person_add,
              size: 40,
            ),
            onTap: () {
              Navigator.popAndPushNamed(
                context, '/newUser',
              );
            },
          ),
        ),
      ],
    ),
    body: Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        children: [
          UserFormWidget(
            user: users.isEmpty ? null : users[index],
            onSavedUser: (user) async {
              await UserSheetApi.update(user.id!, user.toJson());
              refreshUser();
            }
          ),
          const SizedBox(height: 16),
          if (users.isNotEmpty) buildUserControls(),
        ],
      ),
    ),
  );

  Widget buildUserControls() => Column(
    children: [
      Butttonwidget(
        text: 'Deletar', 
        onClick: deleteUser,
      ),
      NavigateUsersWidget(
        text: '${index + 1 }/${users.length} Clientes',
        onClickNext: () {
          final nextIndex = index >= users.length - 1 ? 0 : index + 1;

          setState(() => index = nextIndex); 
        },
        onClickPrevious: () {
          final previousIndex = index <= 0 ? users.length -1 : index -1;

          setState(() => index = previousIndex);
        },
      ),
    ],
  );

  Future refreshUser() async{
    currentUsers.clear();
    await getUsers();
  }

  Future deleteUser() async {
    final user = users[index];

    await UserSheetApi.deleteById(user.id!);

    final newIndex = index >0 ? index -1 : 0;
    await getUsers(index: newIndex);
  }
}
