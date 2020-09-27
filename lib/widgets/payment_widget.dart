import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/data/wallet_data.dart';
import 'package:snimoz/utils/common_util.dart';

void paymentSheet(BuildContext context) async {
  showModalBottomSheet(
    backgroundColor: Colors.indigo[50],
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    context: context,
    builder: (_) {
      return PaymentSheet();
    },
  );
}

class PaymentSheet extends StatefulWidget {
  @override
  _PaymentSheetState createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  final _paymentFormKey = GlobalKey<FormState>();
  final _smsFormKey = GlobalKey<FormState>();
  final TextEditingController cardNumEditCtrl = TextEditingController();
  final TextEditingController expDateEditCtrl = TextEditingController();
  final TextEditingController cvvEditCtrl = TextEditingController();
  final TextEditingController amountEditCtrl = TextEditingController();
  final TextEditingController smsEditCtrl = TextEditingController();

  bool smsSent = false;

  @override
  Widget build(BuildContext context) {
    final WalletData walletData = Provider.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: !smsSent,
            child: Form(
              key: _paymentFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: cardNumEditCtrl,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            // color: APP_BROWN_COLOR,
                            ),
                      ),
                      icon: Icon(
                        Icons.credit_card,
                        size: 20,
                      ),
                      labelText: 'Card Number',
                      hintText: "xxxx - xxxx - xxxx - xxxx",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter card number';
                      } else if (value.length != 16) {
                        return 'Enter correct card number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                          controller: expDateEditCtrl,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  // color: APP_BROWN_COLOR,
                                  ),
                            ),
                            icon: Icon(
                              Icons.today,
                              size: 20,
                            ),
                            labelText: 'Expiry Date',
                            hintText: "dd/ mm/ yyyy",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter expiry date';
                            } else if (value.length != 10) {
                              return 'Enter correct expiry dater';
                            }
                            return null;
                          },
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          controller: cvvEditCtrl,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  // color: APP_BROWN_COLOR,
                                  ),
                            ),
                            icon: Icon(
                              Icons.calendar_view_day,
                              size: 20,
                            ),
                            labelText: 'CVV',
                            hintText: "xxx",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter cvv';
                            } else if (value.length != 3) {
                              return 'Enter correct cvv';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: amountEditCtrl,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            // color: APP_BROWN_COLOR,
                            ),
                      ),
                      icon: Icon(
                        Icons.attach_money,
                        size: 20,
                      ),
                      prefixText: "₹ ",
                      labelText: 'Amount',
                      hintText: "xxx.xx",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter amount';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: smsSent,
            child: Form(
              key: _smsFormKey,
              child: Column(
                children: [
                  Text(
                    "Enter the verification code received",
                    style: GoogleFonts.lemon(
                      color: Colors.indigo[200],
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: TextFormField(
                      controller: smsEditCtrl,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              // color: APP_BROWN_COLOR,
                              ),
                        ),
                        icon: Icon(
                          Icons.sms,
                          size: 20,
                        ),
                        labelText: 'SMS Code',
                        hintText: "x - x - x - x - x - x",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter sms code';
                        } else if (value.length != 6) {
                          return 'Enter correct sms code';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton.icon(
                color: Colors.indigo[800],
                label: Text(
                  "Cancel",
                  style: GoogleFonts.lemon(
                    color: Colors.indigo[50],
                    fontSize: 16,
                  ),
                ),
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RaisedButton.icon(
                color: Colors.indigo[800],
                label: Text(
                  "Add Cash",
                  style: GoogleFonts.lemon(
                    color: Colors.indigo[50],
                    fontSize: 16,
                  ),
                ),
                icon: Icon(
                  Icons.monetization_on,
                  color: Colors.amber,
                ),
                onPressed: () async {
                  if (!smsSent) {
                    if (_paymentFormKey.currentState.validate()) {
                      setState(() {
                        smsSent = true;
                      });
                    }
                  } else {
                    if (smsEditCtrl.text != "123456") {
                      showToast("Invalid SMS Code");
                      return;
                    }
                    await walletData.addTransaction(
                        amount: double.parse(amountEditCtrl.text));
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
