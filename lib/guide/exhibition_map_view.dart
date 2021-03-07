import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExhibitionMapView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    AppLocalizations _locals = AppLocalizations.of(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(mediaQueryData.size.height * 0.07),
          child: CustomDefaultAppbar(title: _locals.map9)
        ),
        body: Container(
          width: double.infinity,
          color: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Image.asset(
            "assets/images/map.png",
            fit: BoxFit.fitHeight,
          ),
        )
    );
  }
}
