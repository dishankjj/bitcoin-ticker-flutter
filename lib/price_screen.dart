import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

enum dataaa {
  AUD,
  BRL,
  CAD,
  CNY,
  EUR,
  GBP,
  HKD,
  IDR,
  ILS,
  INR,
  JPY,
  MXN,
  NOK,
  NZD,
  PLN,
  RON,
  RUB,
  SEK,
  SGD,
  USD,
  ZAR
}

final int selectInitialScrollValue = dataaa.INR.index;
final String setInitialCurrency = 'INR';

class PriceScreen extends StatefulWidget {
  final CoinData coinData = new CoinData();

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map<String, String> finalRate = {};
  List<String> coins = ['BTC', 'ETH', 'LTC'];
  String currency = setInitialCurrency;

  Future<void> exchangeRate() async {
    Map<String, String> exchangeRate =
        await widget.coinData.getExchangeRate(coins, currency);
    setState(() {
      finalRate.addAll(exchangeRate);
    });
  }

  CupertinoPicker cupertinoPicker() {
    return CupertinoPicker(
      onSelectedItemChanged: (int value) {
        setState(() {
          exchangeRate();
          currency = widget.coinData.getCurrencyOptions()[value].toString();
          finalRate = {};
        });
      },
      itemExtent: 32.0,
      children: widget.coinData.getTextCurrencyOptions(),
      scrollController:
          FixedExtentScrollController(initialItem: selectInitialScrollValue),
    );
  }

  @override
  void initState() {
    super.initState();
    exchangeRate();
    currency = widget.coinData.getCurrencyOptions()[selectInitialScrollValue];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${finalRate['BTC'] == null
                      ? 'FETCH'
                      : finalRate['BTC']} $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = ${finalRate['ETH'] == null
                      ? 'FETCH'
                      : finalRate['ETH']} $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = ${finalRate['LTC'] == null
                      ? 'FETCH'
                      : finalRate['LTC']} $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            children: <Widget>[],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: cupertinoPicker(),
          ),
        ],
      ),
    );
  }
}
