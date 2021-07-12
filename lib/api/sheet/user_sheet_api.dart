import 'package:clientes_inadimplentes_2/model/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  static final _credentials = r'''
{
  "type": ,
  "project_id": ,
  "private_key_id": ,
  "private_key": 
  "client_email": ,
  "client_id": ,
  "auth_uri": ,
  "token_uri": ,
  "auth_provider_x509_cert_url": ,
  "client_x509_cert_url":
}
  ''';
  
  static final _spreadSheetId = 'Your Spread Sheet ID : ID da planilha de trabalho';
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static final _sheetTitle = 'Titulo da planilha';

  static Future init() async {
    try { final spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: _sheetTitle);

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);

    } catch (e) {
      print('Init Error $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet, {required String title,})
  async {
    try {
      return await spreadsheet.addWorksheet(title);
    }catch (e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<List<User>> getAll() async {
    if (_userSheet == null) return <User>[];
    
    final users = await _userSheet!.values.map.allRows();
    
    return users == null ? <User>[] : users.map(User.fromJson).toList();
  }
  
  static Future<User?> getById(int id) async {
    if (_userSheet == null) return null;

    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<bool> update(
    int id,
    Map<String, dynamic> user,
  ) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.map.insertRowByKey(id, user);
  }

  static Future<bool> updateCell({
    required int id,
    required String key,
    required dynamic value,
  }) async {
    if (_userSheet == null) return false;

    return _userSheet!.values.insertValueByKeys(
      value, 
      columnKey: key, 
      rowKey: id,
    );
  }

  static Future<bool> deleteById(int id) async {
    if (_userSheet == null) return false;

    final index = await _userSheet!.values.rowIndexOf(id);
    if (index == -1) return false;

    return _userSheet!.deleteRow(index);
  }
}