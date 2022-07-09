import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_riverpod/ui/app.dart';
import 'package:learning_riverpod/ui/providers.dart';

import 'detail_notifier.dart';

class DetailPage extends ConsumerWidget {
  static const id = '/detail_page';

  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rougeArgs = ModalRoute.of(context)!.settings.arguments as RouteArgs;

    final detailController = ref.watch(
      detailNotifierProvider(rougeArgs.detailState),
    );
    detailController.setContact = rougeArgs.contact;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          if (detailController.state == DetailState.read)
            IconButton(
              onPressed: () => detailController.pressedEdit(context),
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            )
          else
            IconButton(
              onPressed: () => detailController.pressedSave(context),
              icon: const Icon(
                Icons.check,
                color: Colors.black,
              ),
            )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              readOnly: detailController.readOnly,
              autofocus: !detailController.readOnly,
              controller: detailController.nameController
                ..text = rougeArgs.contact?.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                hintText: "Name",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                readOnly: detailController.readOnly,
                expands: true,
                maxLines: null,
                controller: detailController.numberController
                  ..text = rougeArgs.contact?.number ?? '',
                style: const TextStyle(
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
