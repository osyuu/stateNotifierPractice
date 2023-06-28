import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_notifier_practice/search/search_notifier.dart';
import 'package:state_notifier_practice/search/search_usecase.dart';

import 'search_notifier_test.mocks.dart';

abstract class ChangeListener<T> {
  void call(T? previous, T next);
}

@GenerateMocks([SearchUseCase, ChangeListener])
void main() {
  final mockUseCase = MockSearchUseCase();
  final listener = MockChangeListener<AsyncValue<List<String>>>();

  SearchNotifier init() {
    final container = ProviderContainer(
      overrides: [
        searchUseCaseProvider.overrideWithValue(mockUseCase),
      ],
    );
    addTearDown(container.dispose);
    container.listen(
      searchNotifierProvider,
      listener,
      fireImmediately: true,
    );
    return container.read(searchNotifierProvider.notifier);
  }

  group("SearchNotifier", () {
    setUp(() {
      reset(listener);
      reset(mockUseCase);
    });

    group("initial search", () {
      test("data", () async {
        when(mockUseCase.call(any)).thenAnswer(
              (_) async => ["result"],
        );
        final viewModel = init();
        await viewModel.future;

        verifyInOrder([
          listener.call(argThat(isNull), argThat(isA<AsyncLoading>())),
          listener.call(
            argThat(isA<AsyncLoading>()),
            argThat(isA<AsyncData>()
                .having((d) => d.requireValue, "value", ["result"])),
          ),
        ]);
        verify(mockUseCase.call("keyword")).called(1);
      });
      test("empty", () async {
        when(mockUseCase.call(any)).thenAnswer(
              (_) async => [],
        );
        final viewModel = init();
        await viewModel.future;

        verifyInOrder([
          listener.call(argThat(isNull), argThat(isA<AsyncLoading>())),
          listener.call(
            argThat(isA<AsyncLoading>()),
            argThat(
                isA<AsyncData>().having((d) => d.requireValue, "value", [])),
          ),
        ]);
        verify(mockUseCase.call("keyword")).called(1);
      });
      test("error", () async {
        when(mockUseCase.call(any)).thenAnswer(
              (_) async => throw Exception("test"),
        );
        final viewModel = init();
        await expectLater(
              () => viewModel.future,
          throwsException,
        );

        verifyInOrder([
          // 検索中
          listener.call(argThat(isNull), argThat(isA<AsyncLoading>())),
          // 検索失敗
          listener.call(
            argThat(isA<AsyncLoading>()),
            argThat(isA<AsyncError>()),
          ),
        ]);
        verify(mockUseCase.call("keyword")).called(1);
      });
    });

    group("search", () {
      test("data > data", () async {
        when(mockUseCase.call(any)).thenAnswer(
              (_) async => ["result1"],
        );
        final viewModel = init();
        await viewModel.future;

        when(mockUseCase.call(any)).thenAnswer(
              (_) async => ["result2"],
        );
        await viewModel.search("keyword2");

        verifyInOrder([
          //　検索中（初期化）
          listener.call(argThat(isNull), argThat(isA<AsyncLoading>())),
          // 検索完了（初期化成功）
          listener.call(
            argThat(isA<AsyncLoading>()),
            argThat(isA<AsyncData>()
                .having((d) => d.requireValue, "value", ["result1"]).having(
                    (d) => d.isLoading, "isLoading", isFalse)),
          ),
          // 検索中（２回目）
          listener.call(
            argThat(isA<AsyncData>()),
            argThat(isA<AsyncData>()
                .having((d) => d.requireValue, "value", ["result1"]).having(
                    (d) => d.isLoading, "isLoading", isTrue)),
          ),
          // 検索完了（２回目）
          listener.call(
            argThat(isA<AsyncData>()),
            argThat(isA<AsyncData>()
                .having((d) => d.requireValue, "value", ["result2"]).having(
                    (d) => d.isLoading, "isLoading", isFalse)),
          ),
        ]);
        verifyInOrder([
          mockUseCase.call("keyword"),
          mockUseCase.call("keyword2"),
        ]);
      });
      test("data > error", () async {
        when(mockUseCase.call(any)).thenAnswer(
              (_) async => ["result1"],
        );
        final viewModel = init();
        await viewModel.future;

        when(mockUseCase.call(any)).thenAnswer(
              (_) async => throw Exception("test"),
        );
        await viewModel.search("keyword2");

        verifyInOrder([
          listener.call(argThat(isNull), argThat(isA<AsyncLoading>())),
          listener.call(
            argThat(isA<AsyncLoading>()),
            argThat(isA<AsyncData>()
                .having((d) => d.requireValue, "value", ["result1"]).having(
                    (d) => d.isLoading, "isLoading", isFalse)),
          ),
          listener.call(
            argThat(isA<AsyncData>()),
            argThat(isA<AsyncData>()
                .having((d) => d.requireValue, "value", ["result1"]).having(
                    (d) => d.isLoading, "isLoading", isTrue)),
          ),
          listener.call(
            argThat(isA<AsyncData>()),
            argThat(isA<AsyncError>()
                .having((d) => d.hasValue, "hasValue", isTrue)
                .having((d) => d.requireValue, "value", ["result1"]).having(
                    (d) => d.isLoading, "isLoading", isFalse)),
          ),
        ]);
        verifyInOrder([
          mockUseCase.call("keyword"),
          mockUseCase.call("keyword2"),
        ]);
      });

      test("error > data", () async {
        when(mockUseCase.call(any)).thenAnswer(
              (_) async => throw Exception("test"),
        );
        final viewModel = init();
        await expectLater(
              () => viewModel.future,
          throwsException,
        );

        when(mockUseCase.call(any)).thenAnswer(
              (_) async => ["result2"],
        );
        await viewModel.search("keyword2");

        verifyInOrder([
          listener.call(argThat(isNull), argThat(isA<AsyncLoading>())),
          listener.call(
            argThat(isA<AsyncLoading>()),
            argThat(isA<AsyncError>()
                .having((d) => d.isLoading, "isLoading", isFalse)),
          ),
          listener.call(
            argThat(isA<AsyncError>()),
            argThat(isA<AsyncError>()
                .having((d) => d.isLoading, "isLoading", isTrue)),
          ),
          listener.call(
            argThat(isA<AsyncError>()),
            argThat(isA<AsyncData>()
                .having((d) => d.hasError, "hasError", isFalse)
                .having((d) => d.requireValue, "value", ["result2"]).having(
                    (d) => d.isLoading, "isLoading", isFalse)),
          ),
        ]);
        verifyInOrder([
          mockUseCase.call("keyword"),
          mockUseCase.call("keyword2"),
        ]);
      });
    });
  });
}