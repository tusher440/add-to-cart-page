import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Database/db_helper.dart';
import '../Model/data_base_model.dart';
import '../Provider/cart_counter.dart';
import '../SCREEN/homepage.dart';

class EmployeesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmployeesListState();
  }
}

class EmployeesListState extends State<EmployeesList> {
  List<Employee> listEmployees = [];

  Future<List<Map<String, dynamic>>> getEmployees() async {
    List<Map<String, dynamic>> listMap =
        await DatabaseHelper.instance.queryAllRows();
    setState(() {
      listMap.forEach((map) => listEmployees.insert( 0 ,Employee.fromMap(map)));
    });
    return listMap;
  }

  @override
  void initState() {
    CartCounter cartCounter =Provider.of<CartCounter>(context , listen: false);
    cartCounter.loadCounter();
    // TODO: implement initState
    getEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  CartCounter cartCounter =Provider.of<CartCounter>(context , );

    // TODO: implement build

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(listEmployees.length.toString()),centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddEditEmployee(false)));
              },
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
                itemCount: listEmployees.length,
               // reverse: true,
                itemBuilder: (context, position) {
                  Employee getEmployee = listEmployees[position];
                  var salary = getEmployee.productPrice;
                  var age = getEmployee.productTotalPrice;
                  var productquantyti=getEmployee.productQuntity;
                  return Card(
                    elevation: 8,
                    child: Container(
                      height: 80,
                      padding: EdgeInsets.all(15),
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(getEmployee.productName!,
                                  style: TextStyle(fontSize: 18))),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Container(
                          //     margin: EdgeInsets.only(right: 45),
                          //     child: IconButton(
                          //         icon: Icon(Icons.edit),
                          //         onPressed: () {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (_) => AddEditEmployee(
                          //                       true, getEmployee)));
                          //         }),
                          //   ),
                          // ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                       cartCounter.decrementCounter();
                                  DatabaseHelper.instance
                                      .delete(getEmployee.productId!);
                                  setState(() => {
                                        listEmployees.removeWhere((item) =>
                                            item.productId == getEmployee.productId)
                                      });
                                }),
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Salary: $salary | Age: $age",
                                  style: TextStyle(fontSize: 18))),
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}




