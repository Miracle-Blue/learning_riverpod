import 'package:flutter/material.dart';
import 'package:learning_riverpod/domain/entities/contact.dart';
import 'package:learning_riverpod/domain/services/contact_servise.dart';
import 'package:learning_riverpod/ui/app.dart';

import 'detail_page.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

enum DetailState { read, edit, creat }

class DetailNotifier extends ChangeNotifier {
  final ContactApiProvider _contactApiProvider;

  late DetailState state;
  Contact? contact;

  bool readOnly = false;
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  DetailNotifier(
    this.state,
    this._contactApiProvider,
  );

  set setContact(Contact? contact) {
    this.contact ??= contact;

    if (state == DetailState.read) {
      readOnly = true;
    } else {
      readOnly = false;
    }
  }

  void pressedEdit(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      DetailPage.id,
      arguments: RouteArgs(
        detailState: DetailState.edit,
        contact: contact,
      ),
    );
  }

  void pressedSave(BuildContext context) async {
    switch (state) {
      case DetailState.creat:
        try {
          await _contactApiProvider.createContact({
            'name': nameController.text.trim(),
            'number': numberController.text.trim()
          });
        } catch (e) {
          e.log();
        }
        break;
      case DetailState.edit:
        try {
          await _contactApiProvider.updateContact(
            contact!.id,
            {
              'name': nameController.text.trim(),
              'number': numberController.text.trim()
            },
          );
        } catch (e) {
          e.log();
        }
        break;
      default:
        break;
    }

    Navigator.pop(context);
  }
}
