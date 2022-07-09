import 'package:learning_riverpod/domain/entities/contact.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.loading() = Loading;
  const factory HomeState.loaded(List<Contact> contacts) = ListContactData;
  const factory HomeState.error({required String message}) = Error;
}
