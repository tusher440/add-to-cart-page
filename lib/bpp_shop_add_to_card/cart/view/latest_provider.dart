import 'package:flutter/cupertino.dart';

import 'latest_http.dart';
import 'latest_model.dart';



class LatestProvider extends ChangeNotifier{
  List<MostPopularAll>getLatestlist=[];
  getLatestProvider()async{
    var data = await LatestService().getLatestService();
    getLatestlist=data.mostPopularAll!;
    print("LatestProduct:${getLatestlist.length}");
    notifyListeners();

  }
}