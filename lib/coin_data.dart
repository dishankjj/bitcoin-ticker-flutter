import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://min-api.cryptocompare.com/data/pricemulti';
const apiKey =
    '0fc4379f875a8a0f3c9dc4b881e4259955b7becc60dd798a14519c9a54bb85e6';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<Map<String, String>> getExchangeRate(
      List<String> fromWhat, String intoWhat) async {
    String parseFromWhat = '';
    for (int i = 0; i < fromWhat.length; i++) {
      if (i != 0) parseFromWhat += ',';
      parseFromWhat += fromWhat[i];
    }

    http.Response response = await http
        .get('$apiUrl?fsyms=$parseFromWhat&tsyms=$intoWhat&api_key=$apiKey');
    String data = response.body;

    Map<String, String> exchangeRate = {};
    fromWhat.forEach((element) {
      exchangeRate[element] =
          '${jsonDecode(data)[element]['$intoWhat'].toDouble().toString()}';
    });
    return exchangeRate;
  }

  List<Text> getTextCurrencyOptions() {
    List<Text> data = [];
    currenciesList.forEach((e) {
      data.add(Text(
        e,
        style: TextStyle(color: Colors.white),
      ));
    });
    return data;
  }

  List<String> getCurrencyOptions() {
    List<String> data = [];
    currenciesList.forEach((e) {
      data.add(e);
    });
    return data;
  }
}
