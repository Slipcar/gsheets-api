import 'package:clientes_inadimplentes_2/api/sheet/user_sheet_api.dart';
import 'package:clientes_inadimplentes_2/model/user.dart';
import 'package:clientes_inadimplentes_2/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class NewUserForm extends StatefulWidget {
  final User? user;
  final ValueChanged<User> onSavedUser;

  const NewUserForm({ 
    Key? key,
    this.user, 
    required this.onSavedUser 
  }) : super(key: key);

  @override
  _NewUserFormWidgetState createState() => _NewUserFormWidgetState();
}

class _NewUserFormWidgetState extends State<NewUserForm> {
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

  @override
  void initState() {
    super.initState();
    initUser();
  }

  @override
  void didUpdateWidget(covariant NewUserForm oldWidget) {
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
          buildMensalidades(),
          const SizedBox(height: 16),
          buildValor(),
          const SizedBox(height: 16),
          buildVencimento(),
          const SizedBox(height: 16),
          buildObservacoes(),
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

  Widget buildMensalidades() => TextFormField(
    controller: controllerRetorno,
    decoration: InputDecoration(
      labelText: 'Mensalidades',
      border: OutlineInputBorder(),
    ),
  );

  Widget buildValor() => TextFormField(
    controller: controllerRetorno,
    decoration: InputDecoration(
      labelText: 'Valor',
      border: OutlineInputBorder(),
    ),
  );

  Widget buildVencimento() => TextFormField(
    controller: controllerRetorno,
    decoration: InputDecoration(
      labelText: 'Vencimento',
      border: OutlineInputBorder(),
    ),
  );

  Widget buildObservacoes() => TextFormField(
    controller: controllerRetorno,
    decoration: InputDecoration(
      labelText: 'Observações',
      border: OutlineInputBorder(),
    ),
  );

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
          cobrado: 'N',
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