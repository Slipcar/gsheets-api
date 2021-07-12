import 'dart:convert';

class UserFields {
  static final id = 'id';
  static final cliente = 'cliente';
	static final telefoneCel = 'telefoneCel';
	static final telefoneCom = 'telefoneCom';
	static final vencimento = 'vencimento';
	static final valor = 'valor';
	static final mensalidades = 'mensalidades';
	static final observacoes = 'observacoes';
	static final cobrado = 'cobrado';
	static final retorno = 'retorno';

  static List<String> getFields() =>[id,cliente, telefoneCel, telefoneCom, vencimento, valor, mensalidades, observacoes, cobrado];
}


class User{
  final int? id;
  final String cliente;
  final String telefoneCel;
  final String telefoneCom;
  final String vencimento;
  final String valor;
  final String mensalidades;
  final String observacoes;
  final String cobrado;
  final String retorno;

  const User({
    this.id,
    required this.cliente,
    required this.telefoneCel,
    required this.telefoneCom,
    required this.vencimento,
    required this.valor,
    required this.mensalidades,
    required this.observacoes,
    required this.cobrado,
    required this.retorno,
  });

User copy({
  int? id,
  String? cliente,
  String? telefoneCel,
  String? telefoneCom,
  String? vencimento,
  String? valor,
  String? mensalidades,
  String? observacoes,
  String ? cobrado,
  String ? retorno
}) =>
    User(
      id: id ?? this.id,
      cliente: cliente ?? this.cliente, 
      telefoneCel: telefoneCel ?? this.telefoneCel, 
      telefoneCom: telefoneCom ?? this.telefoneCom, 
      vencimento: vencimento ?? this.vencimento, 
      valor: valor ?? this.valor, 
      mensalidades: mensalidades ?? this.mensalidades, 
      observacoes: observacoes ?? this.observacoes, 
      cobrado: cobrado ?? this.cobrado,
      retorno: retorno ?? this.retorno,
    );

  static User fromJson(Map<String, dynamic> json) => User(
      id: jsonDecode(json[UserFields.id]),
      cliente: json[UserFields.cliente], 
      telefoneCel: json[UserFields.telefoneCel], 
      telefoneCom: json[UserFields.telefoneCom], 
      vencimento: json[UserFields.vencimento], 
      valor: json[UserFields.valor], 
      mensalidades: json[UserFields.mensalidades], 
      observacoes: json[UserFields.observacoes], 
      cobrado: json[UserFields.cobrado],
      retorno: json[UserFields.retorno],
    );

  Map<String, dynamic> toJson() => {
    UserFields.id: id,
    UserFields.cliente: cliente,
    UserFields.telefoneCel: telefoneCel,
    UserFields.telefoneCom: telefoneCom,
    UserFields.vencimento: vencimento,
    UserFields.valor: valor,
    UserFields.mensalidades: mensalidades,
    UserFields.observacoes: observacoes,
    UserFields.cobrado: cobrado,
    UserFields.retorno: retorno,
  };
}
