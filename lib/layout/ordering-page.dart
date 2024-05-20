import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/addressmodel.dart';
import '../model/cartmodel.dart';
import '../provider/oattomodel.dart';
import 'add-address.dart';
import 'choose-delivery.dart';
import 'succeed-page.dart';

class OrderingPage extends StatefulWidget {
  const OrderingPage({super.key});

  @override
  State<OrderingPage> createState() => _OrderingPageState();
}

class _OrderingPageState extends State<OrderingPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<OattoModel>(context, listen: false).fetchProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<OattoModel>(builder: (context, oattoModel, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (oattoModel.selectedOption == 1)
                  Text("รวม ฿${oattoModel.totalPrice + 17}"),
                if (oattoModel.selectedOption == 2)
                  Text("รวม ฿${oattoModel.totalPrice + 50}"),
                if (oattoModel.selectedOption == null)
                  Text("รวม ฿${oattoModel.totalPrice}"),
                ElevatedButton(
                  onPressed: () async {
                    if (oattoModel.AddressList.isNotEmpty || oattoModel.selectedOption != null) {
                      
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const Succeed(),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'เพิ่มที่อยู่จัดส่งและเลือกขนส่ง',
                              style: GoogleFonts.prompt(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // content: Text('เกินจำนวนสินค้าที่มีอยู่'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // ปิด Alert Dialog
                                },
                                child: Text(
                                  'ตกลง',
                                  style: GoogleFonts.prompt(
                                    fontSize: 14,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    "สั่งสินค้า",
                    style: GoogleFonts.prompt(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            );
          }),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "เช็คเอาท์",
          style: GoogleFonts.prompt(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            // Address Button
            Consumer<OattoModel>(builder: (context, oattoModel, child) {
              List<AddressButton> addressbutton = oattoModel.AddressList;
              return Column(
                children: [
                  if (addressbutton.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton(
                              onPressed: () async {
                                openDialog(
                                  context,
                                );
                              },
                              child: const Text("เพิ่มที่อยู่จัดส่ง"))),
                    ),
                  if (addressbutton.isNotEmpty)
                    InkWell(
                      onTap: () {
                        openDialog(
                          context,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            addressbutton[0].addressName ?? ""),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(addressbutton[0].addressPhone ??
                                            ""),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("ที่อยู่ : "),
                                        Text(
                                            addressbutton[0].addressText ?? ""),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("ตำบล / เขต : "),
                                        Text(addressbutton[0].selectedTambon ??
                                            ""),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("อำเภอ / แขวง : "),
                                        Text(addressbutton[0].selectedAmphoe ??
                                            ""),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("จังหวัด : "),
                                        Text(
                                            addressbutton[0].selectedProvince ??
                                                ""),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("รหัสไปรษณีย์ : "),
                                        Text(addressbutton[0].selectedZipcode ??
                                            ""),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
            // End Address Button
            Consumer<OattoModel>(builder: (context, oattoModel, child) {
              List<Cart> cartList = oattoModel.selectedCartItems;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            cartList[index].productImg!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(
                                                  Icons
                                                      .image_not_supported_outlined,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Text(
                                              cartList[index].productName ??
                                                  "Name Product",
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "ราคา : ${cartList[index].productPrice} ฿",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                const SizedBox(height: 5),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        height: 30,
                                        child: Text(
                                          "x${cartList[index].valcount}",
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
            Consumer<OattoModel>(builder: (context, oattoModel, child) {
              return Column(
                children: [
                  if (oattoModel.selectedOption == null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton(
                              onPressed: () async {
                                openModalBottom(
                                  context,
                                );
                              },
                              child: const Text("เลือกขนส่ง"))),
                    ),
                  if (oattoModel.selectedOption == 1)
                    InkWell(
                      onTap: () async {
                        openModalBottom(
                          context,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Standard Delivery"),
                                    Column(
                                      children: [
                                        Text("17 บาท"),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("จะรับภายใน 18-19 Apr"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (oattoModel.selectedOption == 2)
                    InkWell(
                      onTap: () async {
                        openModalBottom(
                          context,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Premiumn Delivery"),
                                    Column(
                                      children: [
                                        Text("50 บาท"),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("จะรับภายใน 15-16 Apr"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),

            Consumer<OattoModel>(builder: (context, oattoModel, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Merchandise Subtotal (${oattoModel.totalValCount} items)"),
                            Text("฿${oattoModel.totalPrice}")
                          ],
                        ),
                        if (oattoModel.selectedOption != null)
                          const SizedBox(
                            height: 15,
                          ),
                        if (oattoModel.selectedOption == 1)
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Shipping Fee Subtotal"),
                              Text("฿17.0"),
                            ],
                          ),
                        if (oattoModel.selectedOption == 2)
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Shipping Fee Subtotal"),
                              Text("฿50.0")
                            ],
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (oattoModel.selectedOption == 1)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total"),
                              Text("฿${oattoModel.totalPrice + 17}")
                            ],
                          ),
                        if (oattoModel.selectedOption == 2)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total"),
                              Text("฿${oattoModel.totalPrice + 50}")
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

void openModalBottom(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return const ChooseDelivery();
    },
  );
}

void openDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) {
      return const AddAddress();
    },
  );
}
