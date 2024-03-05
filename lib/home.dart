import 'package:card_flutter/card_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardViewScreen extends StatefulWidget {
  // The parameters
  final Map<String, dynamic> dictionaryMap = {

    "operator": {"publicKey": "pk_test_7A8W2Tpu4gm65SDtl3MdQwHI"},
    "scope": "AuthenticatedToken",
    "order": {
      "description": "Authentication description",
      "currency": "KWD",
      "amount": 1,
      "id": "",
      "reference": "",
    },
    "customer": {
      "id": "",
      "name": [
        {
          "first": "TAP",
          "middle": "",
          "lang": "en",
          "last": "PAYMENTS"
        }
      ],
      "contact": {
        "email": "tap@tap.company",
        "phone": {"countryCode": "+965", "number": "88888888"}
      }
    },

    "features": {
      "customerCards": {"saveCard": true, "autoSaveCard": true},
      "alternativeCardInputs": {
        "cardScanner": true,
        "cardNFC": false,
      },
      "acceptanceBadge": true,
    },
    "post": const {"url": "https://tap.company"},
    // "customer": {
    //   "id": "",
    //   "name": const [
    //     {"first": "TAP", "middle": "", "lang": "en", "last": "PAYMENTS"}
    //   ],
    //   "editable": true,
    //   "contact": const {
    //     "email": "tap@tap.company",
    //     "phone": {"countryCode": "+965", "number": "88888888"}
    //   },
    //   "nameOnCard": "",
    // },
    "fieldVisibility": {
      "card": {"cardHolder": true}
    },
    "merchant": {"id": ""},
    "interface": {
      "powered": true,
      "colorStyle": "colored",
      "theme": "light",
      "locale": "en",
      "edges": "curved",
      "cardDirection": "dynamic",
      "loader": true
    },
    "purpose": "Transaction",
    // "operator": {
    //   "publicKey": "",
    // },
    // "scope": "Token",
    // "order": {
    //   "description": "",
    //   "currency": "SAR",
    //   "amount": 1.0,
    //   "id": "",
    //   "reference": "",
    //   "metadata": const {}
    // },
    "invoice": {"id": ""},
    "acceptance": {
      "supportedPaymentAuthentications": ["3DS"],
      "supportedFundSource": ["CREDIT", "DEBIT"],
      "supportedSchemes": [
        "AMERICAN_EXPRESS",
        "MADA",
        "MASTERCARD",
        "VISA",
        "OMANNET"
      ],
    }
  };

  @override
  State<CardViewScreen> createState() => _CardViewScreenState();
}

class _CardViewScreenState extends State<CardViewScreen> {
  dynamic mCardSDKResponse;
// This is a stateful variable and will be passed to our widget.
// Once you make it true, the card sdk will start in the tokenization process.
  bool generateToken = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            CupertinoIcons.back,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add the card widget
          TapCardViewWidget(
            sdkConfiguration: widget.dictionaryMap,

            /// Will be called once the card is redenred
            onReady: () {},

            /// Will be called once the card is focused
            onFocus: () {
              setState(() {
                /// defensive coding, to disable tokenization process if the user is editng the card
                generateToken = false;
              });
            },

            /// Will be called once the token requested is generated
            onSuccess: (String? success) {},

            /// Will be called once the user enters valid card data
            onValidInput: (String? validInput) {
              setState(() {
                /// defensive coding, to disable tokenization process if the user is editng the card
                generateToken = true;
              });
            },

            /// Will be called once the height of the card form changed
            onHeightChange: (String? heightChange) {},

            /// Will be called once the binlookup for the card is available
            onBindIdentification: (String? bindIdentification) {},

            /// Will indicate whether the user activated the save card switch or disabled it
            onChangeSaveCard: (String? saveCard) {},

            /// Will be called once there is an error happened
            onError: (String? error) {},

            /// Once you want to generate a token, change the state of this var to true
            generateToken: true,
          ),
        ],
      ),
    );
  }
}
