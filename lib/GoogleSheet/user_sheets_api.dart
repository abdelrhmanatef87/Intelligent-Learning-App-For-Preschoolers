import 'package:gsheets/gsheets.dart';
import 'package:intelligent_learning/GoogleSheet/user.dart';

class UserSheetsApi{
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "intelligent-learning-382710",
  "private_key_id": "e5dd4b4018687d0836ea2c6bc2fa4e56b44d08a7",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCBChWCdgoTnY2y\npkf6Ibk0mxDbkHxL8g8MSJurMkJJ/wJ2btSEzwZ42c7CcDdiCrYlR6pNx/3WHV7C\n6/bkw8oOsA0jzAADQ5TexhimWcmmeB1aPlW6KWTGydkA0+XG6hwF11/Kaozn3sP2\nDyotOfpCbhjAtWk1PChesApG+P1qx8/j+jvwTrpmxxYk3aPLg9NxMSwPXAKrScnA\nt5B0OJbZVpj9aZpxypTyMz1mabw+RoGklgXyXfmZ1m2xUV/tAUoGgjKT/QYFt0DA\n5l3cg4OcOZCXBjLdtDkgjCTcr/3eMlOioKO4ETlLV9XKw+uB/CUvJYvYdcwLvTeQ\nXMP1LUxfAgMBAAECggEACvBuaLbAsu9WiFsasKSe5/aaBBW9xnhuTdByoJ2W9gvw\nIFcpSAWpmvbSqt7K1dJqT5hsN8IpDYzu2spt40Xf1sVA+pRm5IqcT73DxYfIwFvg\nF9A/Vz6pbvAZ/T0kIRaj/9twIPT4c120siLl+fCM0TM2gPvAFVsUtwuTIMzR5Z/i\nTwrvnysMpJyzxCh/xRqWMOYeKLvrFIYyfBlHpvM5ZNqASOd3HedS6GRvJ0KJX06C\nROTlLamZiWeKRnH9qL2tDO+7vSSKNrNXsr+oxd+gFlGH1ZJsyFnR8FCd5f1DIGH6\nO0FehoQKTKaycKSTtwu3iw2VaRNCfSWDLvqQe6cFgQKBgQC2AX5UbOhCqSZusVme\npms5I+xT6ad8grk0F0F3Ns0Gq6uh808seDdICIl/M7/lSUmN8iYL3AGcD7/UBUx+\nAqY13fIuxJug6xtQkm11C7qcSEaz2LfH+dDwYutWkEJAfOZkruqYV85IlyTsJfdg\npH22xhCpUaLAKcZwjIhsg0PEgQKBgQC1gAkQP7RJS25drAKVXvvl6n6tRWkmRf7i\n84rEq0hj2xIagh/GDP/30Ako+1C8E+9LSZpjWWQa3WKyboQhACCdoj2cuYD1BDxe\nu6sp8eN8DdAgxbpuLApv1NlHk+0Z0hMdRbuBzwWE/wOMW/ESwBd9V7JfWARYuq7E\nCxkrBhUg3wKBgGSGPKUapcmzrTN0JuCWYCBmM/BA3C3L8cjQk2rpzKHDjX9caD1S\nhI33kSG9jl5wdPy+Yr8oG4d7t2K+LnpmsjCMTmgAVUiyshp1VZlRChepX8uThiYg\nV4N9zye3c7A0i/fOGGpeDORQ/qajbZdmIr0hdjBek3p5WE3vgKYWdgaBAoGAVyr1\nr2MY//aFO+Gnn/ttOT/EtQzX8jS9tFvI8qlca/DDog2KmwCVUnwMWi1Q2fMtAtiH\nmF1PMYPPqehf9sVr5KkNtB53a7UsFUdGbi+o1GSB56tu3Qizvn/YFoNZ5QO6gF2E\nL1Swzu3200s43Yt5/I3IsffApqiJ1MeLv9j8/rsCgYA+3fsJDipTM/nLDX+j60rL\niQcXcwCT9wBCCp6scIXf1Rnd201ZIVXSzDWLq1cIiUjmgV+JJST97KIwo6XSXLKK\nuJByaAh6r2lE824Q/FHuJHxOGG7Clm2tMGxOcwtVfS81+gJSxPc3QDonmQI9Tt0X\nR2EvCToxRlmepqiZReDH6g==\n-----END PRIVATE KEY-----\n",
  "client_email": "intelligent-learning@intelligent-learning-382710.iam.gserviceaccount.com",
  "client_id": "103110191768216380143",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/intelligent-learning%40intelligent-learning-382710.iam.gserviceaccount.com"
}
  ''';
  static final _spreadsheetId = '1iLMUvIPeviQvbN-TbpqmYfkZ_TKrRcbeYrUTiAEm3pw';
  static final _gsheets = GSheets(_credentials);

  static Worksheet? _userSheet;
  static Future init() async{
    try{
      final spreadshet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadshet, title: 'Users');
      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    }catch(e){
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet, {required String title}) async{
    try{
      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async{
    if(_userSheet == null) return;
    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<List<User_Info>> getAll() async{
    if(_userSheet == null) return <User_Info>[];
    final users = await _userSheet!.values.map.allRows();
    return users == null ? <User_Info>[] : users.map(User_Info.fromJson).toList();
  }

  static Future<User_Info?> getById(String id) async{
    if(_userSheet == null) return null;
    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User_Info.fromJson(json);
  }

  static Future<int> getRowCount() async{
    if(_userSheet == null) return 0;
    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<bool> update(String id, Map<String, dynamic> user) async{
    if(_userSheet == null) return false;
    return _userSheet!.values.map.insertRowByKey(id, user);
  }

  static Future<bool> updateCell({required String id, required String key, required dynamic value}) async{
    if(_userSheet == null) return false;
    return _userSheet!.values.insertValueByKeys(value, columnKey: key, rowKey: id);
  }

  static Future<bool> deleteById(String id) async{
    if(_userSheet == null) return false;
    final index = await _userSheet!.values.rowIndexOf(id);
    if(index == -1) return false;
    return _userSheet!.deleteRow(index);
  }
}