import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rivia/res/bloc/rivia_bloc.dart';
import 'package:rivia/res/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import '../res/bloc/data_bloc.dart';

class EncryptScreen extends StatefulWidget {
  const EncryptScreen({Key? key}) : super(key: key);

  @override
  _EncryptScreenState createState() => _EncryptScreenState();
}

class _EncryptScreenState extends State<EncryptScreen> {
  bool _isDecrypt = false;
  String _text = '';
  String _key = 'emir';

  @override
  Widget build(BuildContext context) {
    Bloc _blocRivia = context.read<RiviaBloc>();
    Bloc _blocData = context.read<DataBloc>();

    _blocData.add(GetKey());

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
              fontSize: 30,
              fontWeight: FontWeight.w700
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          SizedBox(
            width: MediaQuery.of(context).size.width - 90,
            child: TextField(
              onChanged: (value) {
                _text = value;
              },
              onSubmitted: (value) {
                _text = value;
                _isDecrypt ? _blocRivia.add(Decryption(text: _text, key: _key))
                    : _blocRivia.add(Encryption(text: _text, key: _key));
              },
              textAlign: TextAlign.center,
              cursorColor: kBrightColor,
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  color: kBrightColor,
                  fontSize: 16,
                )
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
          const Padding(padding: EdgeInsets.all(10)),
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
                      _showSnackBar(context, _isDecrypt ?
                      AppLocalizations.of(context)!.decryptSnack :
                      AppLocalizations.of(context)!.encryptSnack);
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
                const Padding(padding: EdgeInsets.all(20)),
                ElevatedButton(
                  onPressed: () {
                    _isDecrypt ? _blocRivia.add(Decryption(text: _text, key: _key))
                        : _blocRivia.add(Encryption(text: _text, key: _key));
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(kBrightColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ))
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.button,
                    style: const TextStyle(
                      color: kDarkColor,
                      fontSize: 16
                    ),
                  )
                )
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(25)),
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
            child: BlocBuilder<RiviaBloc, RiviaState>(
              builder: (context, state) {
                if(state is ProcessingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kBrightColor
                    ),
                  );
                }

                if(state is EndedState) {
                  return GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: state.result));
                      _showSnackBar(context, AppLocalizations.of(context)!.copied);
                    },
                    child: Text(
                      state.result,
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          color: kBrightColor,
                          fontSize: 16,
                        )
                      ),
                    ),
                  );
                }

                return const Text(
                  '',
                  style: TextStyle(
                    color: kBrightColor,
                  ),
                );
              },
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
                onPressed: () async {
                  String? temp = await _getClipboardData();
                  setState(() {
                    _key = temp ?? 'emir';
                  });
                  _blocData.add(InsertKey(key: _key));
                },
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _key));
                  _showSnackBar(context, AppLocalizations.of(context)!.copied);
                },
                child: BlocBuilder<DataBloc, DataState>(
                  builder: (_, state) {
                    if(state is DataProcessingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: kBrightColor
                        ),
                      );
                    }

                    if(state is DataEndedState) {
                      _key = state.result;
                      return Text(
                        _key.length > 7 ? _key.substring(0, 6) + '...' : _key,
                        style: const TextStyle(
                          color: kBrightColor,
                          fontSize: 16
                        ),
                      );
                    }

                    return const Text(
                      '',
                      style: TextStyle(
                        color: kBrightColor,
                      ),
                    );
                  }
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: kBrightColor,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 80,
                            height: 98,
                            decoration: BoxDecoration(
                              color: kDarkColor,
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      _key = value;
                                    });
                                    _blocData.add(InsertKey(key: _key));
                                  },
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      _key = value;
                                    });
                                    _blocData.add(InsertKey(key: _key));
                                    Navigator.of(context).pop();
                                  },
                                  initialValue: _key,
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  cursorColor: kBrightColor,
                                  style: const TextStyle(
                                    color: kBrightColor,
                                    fontSize: 16
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: MediaQuery.of(context).size.width - 80,
                                    decoration: const BoxDecoration(
                                      color: kBrightColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)
                                      )
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.changeKeyButton,
                                      style: const TextStyle(
                                        color: kDarkColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kBrightColor,
        duration: const Duration(seconds: 1, milliseconds: 500),
        content: Text(
          content,
          style: const TextStyle(
            color: kDarkColor
          ),
        )
      )
    );
  }

  Future<String?> _getClipboardData() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    return data!.text;
  }
}
