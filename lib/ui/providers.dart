import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_riverpod/domain/services/contact_servise.dart';
import 'package:learning_riverpod/ui/pages/detail/detail_notifier.dart';
import 'package:learning_riverpod/ui/pages/home/controller/home_state.dart';

import 'pages/home/controller/home_notifier.dart';

final contactApiProvider = Provider<ContactApiProvider>(
  (ref) => ContactApiProvider(),
);

final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) {
    return HomeNotifier(ref.watch(contactApiProvider));
  },
);

final detailNotifierProvider =
    ChangeNotifierProvider.family.autoDispose<DetailNotifier, DetailState>(
  (ref, detailState) => DetailNotifier(detailState, ref.watch(contactApiProvider)),
);
