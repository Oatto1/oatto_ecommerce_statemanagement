import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/productmodel.dart';
import '../provider/oattomodel.dart';
import '../style/textstyle.dart';
import 'add-product.dart';
import 'cart-page.dart';

class MainProduct extends StatelessWidget {
  const MainProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Oatto E-Commerce Example",
          style: GoogleFonts.prompt(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const CartPage(),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<OattoModel>(
        builder: (context, oattoModel, child) {
          List<todo> productList = oattoModel.productList;
          // ใช้ productList ที่ได้จาก OattoModel ได้ตามต้องการ
          return Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  // สร้าง Widget สำหรับแสดงข้อมูลแต่ละรายการที่อยู่ใน productList
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   children: [
                            //     Text(
                            //       "uuid : ${productList[index].uuid}",
                            //       style: const TextStyle(
                            //           overflow: TextOverflow.ellipsis),
                            //     ),
                            //     const Spacer(),
                            //     IconButton(
                            //         onPressed: () {
                            //           if (productList[index].uuid != null) {
                            // Provider.of<OattoModel>(context,
                            //         listen: false)
                            //     .deleteProductByUuid(
                            //                     productList[index].uuid!);
                            //           } else {
                            //             return;
                            //           }
                            //         },
                            //         icon: const Icon(Icons.delete))
                            //   ],
                            // ),
                            SizedBox(
                              height: 125,
                              child: Image.asset(
                                productList[index].productImg!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              productList[index].productName ?? "",
                              style: mainProductName
                            ),
                            // Text(productList[index].desc ?? ""),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${productList[index].productPrice ?? ""} บาท",
                                  style: mainProductPrice
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${productList[index].productCount ?? ""}",
                                      style: mainProductTextSmall
                                    ),
                                    Text(
                                      " ชิ้น",
                                      style: mainProductTextSmall
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Provider.of<OattoModel>(context,
                                          listen: false)
                                      .addToCart(index, context);
                               
                                  productList[index].check = true;
                                },
                                child: const Icon(
                                  Icons.shopping_cart,
                                ),
                              ),
                            )
                            // Text(productList[index].createdAt ?? ""),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      // ListView.builder(
      //   itemCount: todos.length,
      //   itemBuilder: (context, index) {
      //     return TodoCard(
      //       todo: todos[index],
      //       ref: ref,
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog(
            context,
          );
        },
        tooltip: 'Create New Todo',
        child: const Icon(
          Icons.add_shopping_cart,
        ),
      ),
    );
  }
}

void openDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) {
      return const AddProduct();
    },
  );
}
