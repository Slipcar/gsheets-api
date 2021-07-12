import 'package:clientes_inadimplentes_2/api/sheet/user_sheet_api.dart';
import 'package:clientes_inadimplentes_2/model/user.dart';
import 'package:clientes_inadimplentes_2/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({ 
    Key? key,
    this.user, 
    required this.onSavedUser 
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  List<User> users = [];
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerCliente;
  late TextEditingController controllerTelefone;
  late TextEditingController controllerTelefoneCom;
  late TextEditingController controllerVencimento;
  late TextEditingController controllerValor;
  late TextEditingController controllerObservacoes;
  late TextEditingController controllerMensalidades;
  late TextEditingController controllerRetorno;
  late bool isCobrado;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    initUser();
  }

  void initUser() {
    final cliente = widget.user == null ? '' : widget.user!.cliente;
    final telefone = widget.user == null ? '' : widget.user!.telefoneCel;
    final telefoneCom = widget.user == null ? '' : widget.user!.telefoneCom;
    final vencimento = widget.user == null ? '' : widget.user!.vencimento;
    final valor = widget.user == null ? '' : widget.user!.valor;
    final mensalidades = widget.user == null ? '' : widget.user!.mensalidades;
    final observacoes = widget.user == null ? '' : widget.user!.observacoes;
    final cobrado = widget.user == null ? '' : widget.user!.cobrado;
    final retorno = widget.user == null ? '' : widget.user!.retorno;

    setState(() {  
      controllerCliente = TextEditingController(text: cliente);
      controllerTelefone = TextEditingController(text: telefone);
      controllerTelefoneCom = TextEditingController(text: telefoneCom);
      controllerVencimento = TextEditingController(text: vencimento);
      controllerValor = TextEditingController(text: valor);
      controllerObservacoes = TextEditingController(text: observacoes);
      controllerMensalidades = TextEditingController(text: mensalidades);
      controllerRetorno = TextEditingController(text: retorno);
      this.isCobrado = validateCobrado(cobrado);
    }); 
  }
  
  @override
  Widget build(BuildContext context) => Form(
      key: formKey,
      child: Center(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildName(),
          const SizedBox(height: 16,),
          buildPhone(),
          const SizedBox(height: 16,),
          buildPhoneCom(),
          const SizedBox(height: 16),
          buildRetorno(),
          Row(
            children: [
              const SizedBox(width: 85),
              buildPhone1(),
              const SizedBox(width: 80),
              buildPhone2(),
            ],
          ),
          buildObservacoes(),
          const SizedBox(height: 16),
          buildCobrado(),
          const SizedBox(height: 16),
          buildSubmit(),
        ],
    ),
      ),
  );

  Widget buildName() => TextFormField(
    controller: controllerCliente,
    decoration: InputDecoration(
      labelText: 'Cliente',
      border: OutlineInputBorder(),
    ),
    validator: (value) => 
    value != null && value.isEmpty ? 'Informe o Nome do Cliente' : null,
  );

  Widget buildPhone() => TextFormField(
    controller: controllerTelefone,
    decoration: InputDecoration(
      labelText: 'Telefone',
      border: OutlineInputBorder(),
    ),
    validator: (value) => value != null && value.isEmpty ? 'Informe o Telefone do Cliente' : null,
  );

  Widget buildPhoneCom() => TextFormField(
    controller: controllerTelefoneCom,
    decoration: InputDecoration(
      labelText: 'Telefone Complemento',
      border: OutlineInputBorder(),
      
    ),
  );

  Widget buildRetorno() => TextFormField(
    controller: controllerRetorno,
    decoration: InputDecoration(
      labelText: 'Retorno',
      border: OutlineInputBorder(),
    ),
  );

  Widget buildPhone1() => Row(
    children: [
      Text(
        '1',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: const EdgeInsets.all(0),
        child: TextButton(onPressed: () => launch('tel:${controllerTelefone.text}'), 
        child: Icon(Icons.phone_android_rounded, size: 45,)),
      ),
    ],
  );

  Widget buildPhone2() => Row(
    children: [
      Text(
        '2',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: TextButton(onPressed: () => launch('tel:${controllerTelefoneCom.text}'), 
        child: Icon(Icons.phone_android_rounded,size: 45,)),
      ),
    ],
  );
  
  Widget buildObservacoes() => Column(
    children:[ 
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(45, 10, 0, 10),
            child: Text(
              'Mensalidades: ${controllerObservacoes.text}',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 0, 10),
            child: Text(
              'Valor: R\$ ${controllerValor.text}',
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(45, 10, 0, 10),
            child: Text(
              'Vencimento: ${controllerVencimento.text}',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(45, 10, 0, 10),
              child: Text(
                '${controllerMensalidades.text}',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget buildCobrado() => SwitchListTile(
    contentPadding: EdgeInsets.zero,
    controlAffinity: ListTileControlAffinity.leading,
    value: isCobrado, 
    title: Text(
      'Cobrado?',
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
    onChanged: (value) => setState(() => isCobrado = value),
  );


  validateCobrado(String cobrado){
    if (cobrado == 'S') {
      return true;
    } else {
      return false;
    } 
  }

  Widget buildSubmit() => Butttonwidget(
    text: 'Salvar', 
    onClick: () {
      final form = formKey.currentState!;
      final isValid = form.validate();

      if (isValid) {
        final id = widget.user == null ? null : widget.user!.id; 
        final user = User(
          id: id,
          cliente: controllerCliente.text, 
          telefoneCel: controllerTelefone.text, 
          telefoneCom: controllerTelefoneCom.text,
          vencimento: controllerVencimento.text, 
          valor: controllerValor.text,
          observacoes: controllerObservacoes.text,
          mensalidades: controllerMensalidades.text,
          retorno: controllerRetorno.text,
          cobrado: isCobrado ? 'S': 'N',
        );
        widget.onSavedUser(user);
      }
    },
  );

  getUsers({int index = 0}) async {
    final users = await UserSheetApi.getAll();
    for (var user in users) {
      if (user.cobrado == 'N') {
        setState(() {
          this.users = users;
        });
      } 
    }
  }
}