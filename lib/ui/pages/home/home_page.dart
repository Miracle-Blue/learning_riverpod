import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_riverpod/domain/entities/contact.dart';
import 'package:learning_riverpod/ui/providers.dart';

class HomePage extends ConsumerWidget {
  static const id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contacts"),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          Duration.zero,
          () => ref.read(homeNotifierProvider.notifier).getContacts(),
        ),
        child: state.when(
          loading: () => const Center(child: CupertinoActivityIndicator()),
          loaded: (contacts) => _HomeContent(contacts: contacts),
          error: (message) => _ErrorWidget(message: message),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[800],
        onPressed: () =>
            ref.read(homeNotifierProvider.notifier).openForCreate(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final List<Contact> contacts;

  const _HomeContent({
    Key? key,
    required this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _ContactsField(
          contact: contacts[index],
        );
      },
    );
  }
}

class _ContactsField extends ConsumerWidget {
  final Contact contact;

  const _ContactsField({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        onTap: () => ref
            .read(homeNotifierProvider.notifier)
            .openForRead(context, contact),
        title: Text(
          contact.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          contact.number,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => ref
                  .read(homeNotifierProvider.notifier)
                  .deleteContact(contact.id),
              icon: const Icon(Icons.delete_outline),
            ),
            IconButton(
              onPressed: () => ref
                  .read(homeNotifierProvider.notifier)
                  .openForEdit(context, contact),
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
