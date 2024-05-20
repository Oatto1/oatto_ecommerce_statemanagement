import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/cartmodel.dart';
import '../provider/oattomodel.dart';
import '../style/textstyle.dart';
import 'ordering-page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool? check1 = false;
  double total1 = 0;

  @override
  void initState() {
    super.initState();
  }

  final clickedStatus = ValueNotifier<bool>(false);

  @override
  void dispose() {
    clickedStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<OattoModel>(builder: (context, oattoModel, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("รวม ฿${oattoModel.totalPrice}"),
                const Padding(padding: EdgeInsets.all(8)),
                ElevatedButton(
                  onPressed: () async {
                    if (oattoModel.checkOrder == true) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const OrderingPage(),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: Text("ชำระเงิน (${oattoModel.totalPrice})"),
                )
              ],
            );
          }),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.prompt(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Consumer<OattoModel>(
        builder: (context, oattoModel, child) {
          List<Cart> cartList = oattoModel.cartList;

          Map<String, int> productQtyMap = {};

          for (int i = 0; i < cartList.length; i++) {
            String uuid = cartList[i].uuid!;
            if (productQtyMap.containsKey(uuid)) {
              productQtyMap[uuid] = productQtyMap[uuid]! + 1;
            } else {
              productQtyMap[uuid] = 1;
            }
          }

          return Container(
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: productQtyMap.length,
              itemBuilder: (context, index) {
                String uuid = productQtyMap.keys.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: cartList[index]
                                .check, // ใช้ _selectedCartItems ในการตรวจสอบสถานะของ Checkbox
                            onChanged: (isChecked) {
                              setState(() {
                                if (isChecked!) {
                                  oattoModel.checkOrder = isChecked;
                                  cartList[index].check = true;
                                  oattoModel.selectedCartItems
                                      .add(cartList[index]);
                                  Provider.of<OattoModel>(context,
                                          listen: false)
                                      .updateCartItemQty(
                                          cartList[index].uuid.toString(),
                                          cartList[index].valcount!.toInt());
                                } else {
                                  oattoModel.checkOrder = isChecked;
                                  cartList[index].check = false;
                                  oattoModel.selectedCartItems
                                      .remove(cartList[index]);
                                  Provider.of<OattoModel>(context,
                                          listen: false)
                                      .updateCartItemQty(
                                          cartList[index].uuid.toString(),
                                          cartList[index].valcount!.toInt());
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.asset(
                                cartList
                                    .firstWhere(
                                        (element) => element.uuid == uuid)
                                    .productImg!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                  cartList
                                          .firstWhere(
                                              (element) => element.uuid == uuid)
                                          .productName ??
                                      "",
                                  style: mainProductPrice),
                              const SizedBox(height: 12),
                              Text(
                                  "฿ ${cartList.firstWhere((element) => element.uuid == uuid).productPrice ?? ""} THB",
                                  style: mainProductPricePurple),
                              const SizedBox(height: 12),
                              Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            cartList[index].valcount =
                                                cartList[index].valcount! - 1;
                                            Provider.of<OattoModel>(context,
                                                    listen: false)
                                                .updateCartItemQty(
                                              cartList[index].uuid.toString(),
                                              cartList[index].valcount!,
                                            );
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        cartList[index].valcount.toString(),
                                        style: GoogleFonts.prompt(
                                          fontSize: 16,
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          if (cartList[index].valcount! <
                                              cartList[index].productCount!) {
                                            setState(() {
                                              cartList[index].valcount =
                                                  cartList[index].valcount! + 1;
                                              Provider.of<OattoModel>(context,
                                                      listen: false)
                                                  .updateCartItemQty(
                                                cartList[index].uuid.toString(),
                                                cartList[index].valcount!,
                                              );
                                            });
                                          } else {
                                            // แสดงข้อความหรือแจ้งเตือนให้ผู้ใช้รู้ว่าไม่สามารถเพิ่มสินค้าได้เนื่องจากเกินจำนวนที่มีอยู่
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'ไม่สามารถเพิ่มสินค้าได้',
                                                    style: mainProductName,
                                                  ),
                                                  content: Text(
                                                      'เกินจำนวนสินค้าที่มีอยู่',
                                                      style: mainProductText14),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // ปิด Alert Dialog
                                                      },
                                                      child: Text(
                                                        'ตกลง',
                                                        style:
                                                            mainProductPricePurple,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
