import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_riverpod/domain/entities/contact.dart';
import 'package:learning_riverpod/domain/services/contact_servise.dart';
import 'package:learning_riverpod/ui/app.dart';
import 'package:learning_riverpod/ui/pages/detail/detail_notifier.dart';
import 'package:learning_riverpod/ui/pages/detail/detail_page.dart';

import 'home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final ContactApiProvider _contactApiProvider;
  late List<Contact> contacts;

  HomeNotifier(this._contactApiProvider) : super(const HomeState.loading()) {
    getContacts();
  }

  void getContacts() async {
    try {
      contacts = await _contactApiProvider.getContacts();
      state = HomeState.loaded(contacts);
    } catch (e) {
      state = HomeState.error(message: 'Error fetching Contacts: $e');
    }
  }

  void deleteContact(String id) async {
    state = const HomeState.loading();

    try {
      final isDeleted = await _contactApiProvider.deleteContact(id);

      if (isDeleted) {
        contacts.removeWhere((element) => element.id == id);
        state = HomeState.loaded(contacts);
      }
    } catch (e) {
      state = HomeState.error(message: 'Error deleting Contacts: $e');
    }
  }

  void openForCreate(BuildContext context) async {
    await Navigator.pushNamed(
      context,
      DetailPage.id,
      arguments: const RouteArgs(
        detailState: DetailState.creat,
        contact: null,
      ),
    );

    getContacts();
  }

  void openForRead(BuildContext context, Contact contact) async {
    await Navigator.pushNamed(
      context,
      DetailPage.id,
      arguments: RouteArgs(
        detailState: DetailState.read,
        contact: contact,
      ),
    );

    getContacts();
  }

  void openForEdit(BuildContext context, Contact contact) async {
    await Navigator.pushNamed(
      context,
      DetailPage.id,
      arguments: RouteArgs(
        detailState: DetailState.edit,
        contact: contact,
      ),
    );

    getContacts();
  }
}
