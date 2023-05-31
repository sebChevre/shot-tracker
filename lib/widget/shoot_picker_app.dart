import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';

import '../model/versions_info.dart';
import '../widget/main_screen.dart';
import '../widget/shoot_position_picker_screen.dart';
import '../widget/ui_constants.dart';

import '../model/shoot.dart';

import '../model/match.dart' as match_lib;
import 'package:http/http.dart' as http;

class ShootPickerApp extends StatefulWidget {
  final match_lib.Match match;

  const ShootPickerApp(this.match, {super.key});

  @override
  State<ShootPickerApp> createState() => _ShootPickerAppState();
}

class _ShootPickerAppState extends State<ShootPickerApp> {
  late match_lib.Match match;
  bool isShootInTrack = false;
  late Shoot shootInTrack;

  _ShootPickerAppState();

  @override
  void initState() {
    super.initState();
    match = widget.match;
  }

  Future<VersionInfo> _loadVersionInfo(http.Client client) async {
    final response = await client.get(Uri.parse('/version.json'));

    return _parseVersionInfo(response.body);
  }

  VersionInfo _parseVersionInfo(String responseBody) {
    dynamic json = jsonDecode(responseBody);

    VersionInfo versionInfo = VersionInfo.noInfos();

    try {
      versionInfo = VersionInfo.fromJson(json);
    } catch (e) {
      print("No version infos available, default will be returned");
    }
    return versionInfo;
  }

  // Calbback pour le main screen sur click bouton shoot
  void clickOnShootCallback(Shoot shootInTrack) {
    setState(() {
      this.shootInTrack = shootInTrack;
      isShootInTrack = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shot Tracker',
        home: Scaffold(
            appBar: AppBar(
              actions: [
                FutureBuilder(
                  future: _loadVersionInfo(http.Client()),
                  builder: (context, AsyncSnapshot<VersionInfo> snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showAboutDialog(
                                context: context,
                                applicationIcon: FlutterLogo(),
                                applicationName: snapshot.data!.appName,
                                applicationVersion: snapshot.data!.version,
                                applicationLegalese: 'SebChevre©seb-chevre.org',
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Source: ${snapshot.data!.branch}',
                                        style: UiConstants.buidInfosLabel,
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Hash: ${snapshot.data!.comitId}',
                                        style: UiConstants.buidInfosLabel,
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'BuildNo: ${snapshot.data!.buildNumber}',
                                        style: UiConstants.buidInfosLabel,
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Time: ${snapshot.data!.time}',
                                        style: UiConstants.buidInfosLabel,
                                      ))
                                ]);
                          });
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              ],
              leading: isShootInTrack
                  ? BackButton(
                      onPressed: () {
                        setState(() {
                          isShootInTrack = false;

                          if (shootInTrack.positionDefined) {
                            match.addShootForTeam(
                                shootInTrack.team, shootInTrack);
                          }
                        });
                      },
                    )
                  : Container(),
              title: Text('Shots Tracker'),
            ),
            body: isShootInTrack
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ShootPositionPickerScreen(
                          shootInTrack: shootInTrack, match: match),
                    ],
                  )
                : MainScreen(
                    match: match,
                    shootCallBack: clickOnShootCallback,
                  )));
  }
}
