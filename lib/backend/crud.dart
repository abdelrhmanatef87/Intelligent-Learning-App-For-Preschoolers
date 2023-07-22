import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

class Crud{
  getRequest(String uri)async{
    try{
      var response = await http.get(Uri.parse(uri));
      if(response.statusCode==200){
        var responsebody = jsonDecode(response.body);
        return responsebody;
      }else{
        print("Error ${response.statusCode}");
      }
    }catch(e){
      print("Error Catch $e");
    }
  }

  postRequest(String uri, Map data)async{
    try{
      var response = await http.post(Uri.parse(uri), body: data);
      if(response.statusCode==200){
        var responsebody = jsonDecode(response.body);
        return responsebody;
      }else{
        print("Error ${response.statusCode}");
      }
    }catch(e){
      print("Error Catch $e");
    }
  }

  postRequestWithFile(String uri, Map data, File file) async{
    var request = await http.MultipartRequest("POST", Uri.parse(uri));
    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, lenght, filename: basename(file.path));
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key]=value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if(myrequest.statusCode==200){
      var responsebody = jsonDecode(response.body);
      return responsebody;
    }else{
      print("Error ${myrequest.statusCode}");
    }
  }
}