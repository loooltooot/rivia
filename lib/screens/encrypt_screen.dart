import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rivia/res/constants.dart';

class EncryptScreen extends StatefulWidget {
  const EncryptScreen({Key? key}) : super(key: key);

  @override
  _EncryptScreenState createState() => _EncryptScreenState();
}

class _EncryptScreenState extends State<EncryptScreen> {
  bool _isDecrypt = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            AppLocalizations.of(context)!.enterText,
            style: const TextStyle(
              color: kBrightColor,
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          SizedBox(
            width: MediaQuery.of(context).size.width - 90,
            child: TextField(
              textAlign: TextAlign.center,
              cursorColor: kBrightColor,
              style: const TextStyle(
                  color: kBrightColor,
                  fontSize: 16
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: kBrightColor,
                      width: 3
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: kBrightColor,
                      width: 3
                  ),
                )
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          SizedBox(
            width: MediaQuery.of(context).size.width - 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ĳ)',
                  style: TextStyle(
                      color: kBrightColor,
                      fontSize: 16
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Container(
                  height: 35,
                  width: 55,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.fromBorderSide(
                          BorderSide(
                              color: kBrightColor,
                              width: 3
                          )
                      )
                  ),
                  child: Switch(
                    value: _isDecrypt,
                    onChanged: (selected) {
                      setState(() {
                        _isDecrypt = !_isDecrypt;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              duration: const Duration(seconds: 1, milliseconds: 500),
                              content: Text(_isDecrypt ?
                              AppLocalizations.of(context)!.decryptSnack :
                              AppLocalizations.of(context)!.encryptSnack
                              )
                          )
                      );
                    },
                    activeTrackColor: Colors.transparent,
                    activeColor: kBrightColor,
                    inactiveTrackColor: Colors.transparent,
                    inactiveThumbColor: kBrightColor,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                const Text(
                  'Aa',
                  style: TextStyle(
                      color: kBrightColor,
                      fontSize: 16
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          Container(
            width: MediaQuery.of(context).size.width - 90,
            height: MediaQuery.of(context).size.height / 3.5,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: const Border.fromBorderSide(
                    BorderSide(
                        color: kBrightColor,
                        width: 3
                    )
                )
            ),
            child: const Text(
              '?result',
              style: TextStyle(
                color: kBrightColor,
                fontSize: 16,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.paste,
                  color: kBrightColor,
                ),
                onPressed: () {},
              ),
              const Text(
                '?key',
                style: TextStyle(
                    color: kBrightColor,
                    fontSize: 16
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: kBrightColor,
                ),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
