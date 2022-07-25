import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../pages/historyscreen.dart';
import '../../pages/home_screen.dart';
import '../../pages/profile.dart';
import '../../pages/wishlist.dart';
import '../../latest_product/component/badge.dart';
import '../cart_provider.dart';
import '../cart_screen.dart';
import 'latest_provider.dart';

class Latest_HomeScreen extends StatefulWidget {
  const Latest_HomeScreen({Key? key}) : super(key: key);

  @override
  State<Latest_HomeScreen> createState() => _Latest_HomeScreenState();
}

class _Latest_HomeScreenState extends State<Latest_HomeScreen> {
  @override
  void initState() {
    LatestProvider latestProvider = Provider.of<LatestProvider>(context,listen: false);
    latestProvider .getLatestProvider();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    LatestProvider latestProvider = Provider.of<LatestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE37D4E),
        elevation: 0,
        title: Center(
          child: Text(
            "Fashion",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            )),
        actions: [
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .8,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 200,
                mainAxisSpacing: 10,
                childAspectRatio: 4 / 4,
                crossAxisSpacing: 30
                // itemCount:latestProvider.getLatestlist.length,
                //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //     mainAxisExtent: 180, maxCrossAxisExtent: 180,
                //     crossAxisSpacing: 15,
                //     childAspectRatio: 2/4
                ),
            itemCount: latestProvider.getLatestlist.length,
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              print(latestProvider.getLatestlist.length);
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          //  height: 100,
                          child: Image(
                            image: NetworkImage('https://bppshops.com/' +
                                '${latestProvider.getLatestlist[index].productThambnail}')
                            //  AssetImage('assets/banner.png'),
                            ,
                            fit: BoxFit.fill,
                            //
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 2, right: 2, top: 20),
                          child: Text(
                            latestProvider.getLatestlist[index].productName
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 15,
                                height: 1.2,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    latestProvider
                                        .getLatestlist[index].sellingPrice
                                        .toString(),
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Text(
                                    latestProvider
                                        .getLatestlist[index].discountPrice
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            Text(
                              'Add to cart',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          print("product added");
                          cart.addItem(
                              latestProvider.getLatestlist[index].id.toString(),
                              double.tryParse(latestProvider
                                  .getLatestlist[index].sellingPrice!)!,
                              latestProvider.getLatestlist[index].productName,
                              'https://bppshops.com/${latestProvider.getLatestlist[index].productThambnail}',
                              1);
                         // Navigator.pop(context);
                        },
                      )

                      // Expanded(
                      //   flex: 2,
                      //   child: ElevatedButton.icon(
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Colors.amber,
                      //       minimumSize: Size(90, 30),
                      //     ),
                      //     onPressed: () {
                      //       // showModalBottomSheet<void>(
                      //       //   isDismissible: false,
                      //       //   isScrollControlled: true,
                      //       //   context: context,
                      //       //   builder: (BuildContext context) {
                      //           // return MyBottomSheet(
                      //           //   productId: get[index].id.toString(),
                      //           //   productImage: get[index].productThambnail !=
                      //           //       null
                      //           //       ? 'https://bppshops.com/${get[index].productThambnail}'
                      //           //       : 'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                      //           //   productName: get[index].productName,
                      //           //   productDetail: get[index].productDescp,
                      //           //   productPrePrice: get[index].discountPrice,
                      //           //   //  shipping: double.tryParse(get[index].shipping!),
                      //           //   color: get[index].productColor,
                      //           //   size: get[index].productSize,
                      //           //   video: get[index].videoLink,
                      //           //   productPrice: double.tryParse(
                      //           //     get[index].sellingPrice!,
                      //           //   ),
                      //           // );
                      //        // },
                      //
                      //     },
                      //     icon: Icon(
                      //       Icons.shopping_bag_outlined,
                      //       color: Colors.white,
                      //       size: 17,
                      //     ),
                      //     label: Text(
                      //       'Add to Bag',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
    ),
      floatingActionButton: Consumer<Cart>(
        builder: (_, cart, ch) => Badge(
          value: cart.itemCount.toString(),
          child: ch!,
          // ch,,
          color: Colors.amber,
        ),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CartScreen()));
          },
          child: Icon(
            Icons.shopping_bag_sharp,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {

                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BottomNavBar(
                        //           currentTab: 0,
                        //           currentScreen: HomeScreen(),
                        //         )),
                        //         (route) => false);
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottom_NavBar(currentTab: 0,currentScreen: Home_Page(),)));
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors
                              .amber, //currentTab == 0 ? Colors.amber,//: Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Colors
                                .amber, //currentTab == 0 ? Colors.amber : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BottomNavBar(
                        //           currentTab: 1,
                        //           currentScreen:MyWishList(),
                        //         )),
                        //         (route) => false);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.favorite_border_outlined,
                          color: Colors
                              .grey, //currentTab == 1 ? Colors.amber : Colors.grey,
                        ),
                        Text(
                          'Favorite',
                          style: TextStyle(
                            color: Colors
                                .grey, //,currentTab == 1 ? Colors.amber: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BottomNavBar(
                        //           currentTab: 2,
                        //           currentScreen: HistoryScreen(),
                        //         )),
                        //         (route) => false);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard_outlined,
                          color: Colors
                              .grey, //currentTab == 2 ? Colors.amber: Colors.grey,
                        ),
                        Text(
                          'History',
                          style: TextStyle(
                            color: Colors
                                .grey, //,currentTab == 2 ? Colors.amber : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BottomNavBar(
                        //           currentTab: 3,
                        //           currentScreen: ProfileScreen(),
                        //         )),
                        //         (route) => false);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color: Colors
                              .grey, //currentTab == 3 ? Colors.amber : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors
                                .grey, //currentTab == 3 ? Colors.amber: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
