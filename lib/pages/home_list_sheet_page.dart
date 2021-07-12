import 'package:clientes_inadimplentes_2/api/sheet/user_sheet_api.dart';
import 'package:clientes_inadimplentes_2/model/user.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeListSheetPage extends StatefulWidget {

  @override
  _HomeListSheetPageState createState() => _HomeListSheetPageState();
}

class _HomeListSheetPageState extends State<HomeListSheetPage> {

  List<User> users = [];
  int index = 0;
  
  @override
  void initState() {
    getUsers();

    super.initState();
  }
  
  getUsers({int index = 0}) async {
    final users = await UserSheetApi.getAll();

    setState(() {
      this.users = users;
      print('Users: $users');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/jcnet.png'),
                  backgroundColor: Colors.white,
                ),
                title: Text(users[index].cliente.toString(), 
                              style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Contato: ${users[index].telefoneCel}',
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)), 
                onTap: () => Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => ClienteLista(
                      cliente: users[index].cliente,
                      telefoneCel: users[index].telefoneCel,
                      telefoneCom: users[index].telefoneCom,
                      observacoes: users[index].observacoes,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ClienteLista extends StatelessWidget {
  final String? cliente, telefoneCel, telefoneCom, observacoes;
  ClienteLista({
    this.cliente, this.telefoneCel, this.telefoneCom, this.observacoes
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do Cliente'),
      ),
      body: clientDetails(),
    );
  }

  clientDetails(){
    return Container(
      padding: EdgeInsets.all(32.0),
      child: ListTile(
        title: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('$cliente\n',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '$telefoneCel',
                  style: TextStyle(
                    fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45, 10, 0, 10),
                  child: TextButton(onPressed: () => launch('tel:$telefoneCel'), child: Icon(Icons.phone_android_rounded)),
                ),
              ],
            ),
            Row(
              children: [
                Text('$telefoneCom', style: TextStyle(fontWeight: FontWeight.w500),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45, 30, 0, 30),
                  child: complemento(telefoneCom)
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text('$observacoes',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ); 
  }

  complemento(comp) {
    if (comp != '') {
      return TextButton(onPressed: () => launch(telefoneCel!), child: Icon(Icons.phone_android_rounded));
    } else {
      return Text('');
    }
  }
}