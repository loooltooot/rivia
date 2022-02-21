import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rivia/res/bloc/data_bloc.dart';
import 'package:rivia/res/models/table_generator.dart';
import 'package:rivia/res/widgets/app_text_button.dart';
import 'package:rivia/res/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Bloc _bloc = context.read<DataBloc>();
    String _seed = '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: 62)),
        Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
            color: kDarkColor,
            fontSize: 30,
            fontWeight: FontWeight.w700
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 62)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextButton(
              title: AppLocalizations.of(context)!.generateTable,
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
                              TextField(
                                onChanged: (value) {
                                  _seed = value;
                                },
                                onSubmitted: (value) {
                                  _bloc.add(InsertTable(table: TableGenerator.generateTable(_seed)));
                                  Navigator.of(context).pop();
                                },
                                autofocus: true,
                                textAlign: TextAlign.center,
                                cursorColor: kBrightColor,
                                style: const TextStyle(
                                    color: kBrightColor,
                                    fontSize: 16
                                ),
                                decoration: InputDecoration(
                                  hintText: 'seed',
                                  hintStyle: TextStyle(
                                    color: kBrightColor.withOpacity(0.5)
                                  ),
                                  border: InputBorder.none
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _bloc.add(InsertTable(table: TableGenerator.generateTable(_seed)));
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
            ),
            const Padding(padding: EdgeInsets.only(top: 6)),
          ],
        )
      ],
    );
  }
}
