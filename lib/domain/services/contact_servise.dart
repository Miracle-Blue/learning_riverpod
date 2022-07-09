import 'dart:convert';

import 'package:learning_riverpod/domain/data_providers/api_provider.dart';
import 'package:learning_riverpod/domain/entities/contact.dart';

class ContactApiProvider {
  final _network = Network();

  // * APIs
  final _apiGetContacts = '/api/v1/contact';
  final _apiGetSingleContact = '/api/v1/contact/'; // 'id'
  final _apiCreateContact = '/api/v1/contact';
  final _apiUpdateContact = '/api/v1/contact/'; // 'id'
  final _apiDeleteContact = '/api/v1/contact/'; // 'id'

  Future<List<Contact>> getContacts() async {
    final response = await _network.get(
      _apiGetContacts,
      _network.paramsEmpty(),
    );

    if (response == null) {
      throw ContactGetApiError();
    }

    final contacts = List<Contact>.from(
      jsonDecode(response).map(
        (e) => Contact.fromJson(e),
      ),
    );

    return contacts;
  }

  Future<Contact> getSingleContact(String id) async {
    final response = await _network.get(
      _apiGetSingleContact,
      _network.paramsGetSingleObject(id),
    );

    if (response == null) {
      throw ContactGetApiError();
    }

    final contact = Contact.fromJson(jsonDecode(response));

    return contact;
  }

  Future<bool> createContact(Map<String, dynamic> newContactToJson) async {
    final response = await _network.post(
      _apiCreateContact,
      newContactToJson,
    );

    if (response == null) {
      throw ContactCreateApiError();
    }

    return true;
  }

  Future<bool> updateContact(
    String contactId,
    Map<String, dynamic> contactToJson,
  ) async {
    final response = await _network.put(
      _apiUpdateContact,
      contactId,
      contactToJson,
    );

    if (response == null) {
      throw ContactUpdateApiError();
    }

    return true;
  }

  Future<bool> deleteContact(String contactId) async {
    final response = await _network.delete(
      _apiDeleteContact,
      contactId,
    );

    if (response == null) {
      throw ContactDeleteApiError();
    }

    return true;
  }
}

class ContactGetApiError {}

class ContactCreateApiError {}

class ContactUpdateApiError {}

class ContactDeleteApiError {}
