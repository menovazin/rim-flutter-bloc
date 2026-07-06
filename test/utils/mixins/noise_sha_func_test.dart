import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/utils/mixins/noise_sha_func.dart';

class _NoiseSha with NoiseShaFunc {}

void main() {
  group('NoiseShaFunc', () {
    final helper = _NoiseSha();

    test('generateNonce returns string of requested length', () {
      expect(helper.generateNonce(16).length, 16);
    });

    test('generateNonce returns different values', () {
      final a = helper.generateNonce();
      final b = helper.generateNonce();
      expect(a, isNot(b));
    });

    test('generateNonce uses default length 32', () {
      expect(helper.generateNonce().length, 32);
    });

    test('sha256ofString returns hex digest', () {
      final input = 'hello';
      final expected = sha256.convert(input.codeUnits).toString();
      expect(helper.sha256ofString(input), expected);
    });
  });
}
