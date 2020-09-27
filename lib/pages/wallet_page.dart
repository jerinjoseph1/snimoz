import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/data/wallet_data.dart';
import 'package:snimoz/widgets/payment_widget.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  void fetchTransactions() {
    final WalletData walletData = Provider.of(context, listen: false);
    walletData.fetchTransactions();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final WalletData walletData = Provider.of<WalletData>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.indigo[900],
              Colors.indigo[800],
              Colors.indigo[400]
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBar(context),
                dashBoard(walletData),
                walletHistory(walletData),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.indigo[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Wallet",
            style: GoogleFonts.pollerOne(
              color: Colors.indigo[50],
              fontSize: 22,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.indigo[100],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget dashBoard(WalletData walletData) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Card(
        elevation: 3,
        color: Colors.indigo[500],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recharge with ₹200 (minimum) to start journey",
                style: GoogleFonts.lemon(
                  color: Colors.indigo[200],
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: 'Current Balance: ',
                  style: GoogleFonts.lemon(
                    color: Colors.indigo[100],
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '₹' + walletData.currentBalance.toString(),
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[50],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                      onPressed: () {
                        paymentSheet(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget walletHistory(WalletData walletData) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transaction History",
            style: GoogleFonts.lemon(
              color: Colors.indigo[50],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          walletData.transactions.isEmpty
              ? Container(
                  width: double.infinity,
                  child: Text(
                    "No transactions found",
                    style: GoogleFonts.lemon(
                      color: Colors.indigo[200],
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: walletData.transactions.length,
                  itemBuilder: (_, i) {
                    int index = walletData.transactions.length - i - 1;
                    double amount = walletData.transactions[index].amount;
                    Color color = amount >= 0.0 ? Colors.green : Colors.red;
                    String indicator = amount >= 0.0 ? "+" : "-";
                    amount = amount >= 0.0 ? amount : (-1 * amount);
                    return Card(
                      color: Colors.indigo[700],
                      child: ListTile(
                        trailing: RichText(
                          text: TextSpan(
                            text: indicator + ' ',
                            style: GoogleFonts.lemon(
                              color: color,
                              fontSize: 15,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "₹" + amount.toString(),
                                style: GoogleFonts.lemon(
                                  color: Colors.indigo[100],
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          DateFormat.yMd().format(DateTime.parse(
                              walletData.transactions[index].date)),
                          style: GoogleFonts.lemon(
                            color: Colors.indigo[100],
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat.jm().format(DateTime.parse(
                              walletData.transactions[index].date)),
                          style: GoogleFonts.lemon(
                            color: Colors.indigo[100],
                            fontSize: 9,
                          ),
                        ),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}
