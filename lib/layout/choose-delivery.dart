import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/oattomodel.dart';

class ChooseDelivery extends StatefulWidget {
  const ChooseDelivery({super.key});

  @override
  State<ChooseDelivery> createState() => _ChooseDeliveryState();
}

class _ChooseDeliveryState extends State<ChooseDelivery> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Consumer<OattoModel>(builder: (context, oattoModel, child) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Standard Delivery'),
                    subtitle: const Text('Get by 18-19 Apr'),
                    trailing: Radio<int>(
                      value: 1,
                      groupValue: oattoModel.selectedOption,
                      activeColor: Colors.deepPurple,
                      fillColor: MaterialStateProperty.all(Colors.deepPurple),
                      splashRadius: 20,
                      onChanged: (value) {
                        setState(() {
                          oattoModel.selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Premiumn Delivery'),
                    subtitle: const Text('Get by 15-16 Apr'),
                    trailing: Radio<int>(
                      value: 2,
                      groupValue: oattoModel.selectedOption,
                      activeColor: Colors
                          .deepPurple, // Change the active radio button color here
                      fillColor: MaterialStateProperty.all(Colors
                          .deepPurpleAccent), // Change the fill color when selected
                      splashRadius: 25, // Change the splash radius when clicked
                      onChanged: (value) {
                        setState(() {
                          oattoModel.selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (oattoModel.selectedOption != null) {
                            oattoModel
                                .selectDelivery(oattoModel.selectedOption!);
                            print(oattoModel.selectedOption);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Confirm")),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
