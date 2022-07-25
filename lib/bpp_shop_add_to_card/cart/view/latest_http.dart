import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'latest_model.dart';

class LatestService{
  Future<LatestProduct_Model>getLatestService()async{
    Map<String,dynamic>?result;
    try{
      String url ="https://bppshops.com/api/most_popular_all";
      http.Response response=await http.get(Uri.parse(url));
      print("sucess${response.body}");
      if(response.statusCode==200){
        result =convert.jsonDecode(response.body);
        print("Latest Service Data: ${response.body}");
        return LatestProduct_Model.fromJson(result!);

      }

    }catch(e){
      print(e.toString());
    }return LatestProduct_Model.fromJson(result!);

  }
}