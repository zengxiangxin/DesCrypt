import 'dart:convert';
import 'dart:typed_data';

import 'package:hex/hex.dart';

class Utils {
  static List<String> hexArray = '0123456789ABCDEF'.split('');

  /// Decode a BigInt from bytes in big-endian encoding.
  static BigInt _decodeBigInt(List<int> bytes) {
    BigInt result = BigInt.from(0);
    for (int i = 0; i < bytes.length; i++) {
      result += BigInt.from(bytes[bytes.length - i - 1]) << (8 * i);
    }
    return result;
  }

  /// Converts a Uint8List to a hex string
  static String byteToHex(Uint8List bytes) {
    return HEX.encode(bytes).toUpperCase();
  }

  static BigInt byteToBigInt(Uint8List bigIntBytes) {
    return _decodeBigInt(bigIntBytes);
  }

  /// Converts a hex string to a Uint8List
  static Uint8List hexToBytes(String hex) {
    return Uint8List.fromList(HEX.decode(hex));
  }

  /// Convert a bigint to a byte array
  static Uint8List bigIntToBytes(BigInt bigInt) {
    return hexToBytes(bigInt.toRadixString(16).padLeft(32, "0"));
  }

  /// Converts a hex string to a binary string
  static String hexToBinary(String hex) {
    return BigInt.parse(hex, radix: 16).toRadixString(2);
  }

  /// Converts a binary string into a hex string
  static String binaryToHex(String binary) {
    return BigInt.parse(binary, radix: 2).toRadixString(16).toUpperCase();
  }

  static Uint8List reverse(Uint8List bytes) {
    Uint8List reversed = Uint8List(bytes.length);
    for (int i = bytes.length; i > 0; i--) {
      reversed[bytes.length - i] = bytes[i - 1];
    }
    return reversed;
  }

  static bool isHexString(String input) {
    List<String> hexChars = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F'
    ];
    for (int i = 0; i < input.length; i++) {
      if (!hexChars.contains(input[i])) {
        return false;
      }
    }
    return true;
  }

  // Convert an integer to a byte array
  static Uint8List intToBytes(int integer, int length) {
    Uint8List ret = Uint8List(length);
    for (int i = 0; i < length; i++) {
      ret[i] = integer & 0xff;
      integer = (integer - ret[i]) ~/ 256;
    }
    return Utils.reverse(ret);
  }

  /// Convert string to byte array
  static Uint8List stringToBytesUtf8(String str) {
    return utf8.encode(str);
  }

  /// Convert byte array to string utf-8
  static String bytesToUtf8String(Uint8List bytes) {
    return utf8.decode(bytes);
  }

  /// Concatenates one or more byte arrays
  ///
  /// @param {List<Uint8List>} bytes
  /// @returns {Uint8List}
  static Uint8List concat(List<Uint8List> bytes) {
    String hex = '';
    bytes.forEach((v) {
      hex += Utils.byteToHex(v);
    });
    return Utils.hexToBytes(hex);
  }

  static Uint8List padding(Uint8List encrypt) {
    if (encrypt == null || encrypt.isEmpty) {
      return encrypt;
    }
    if (encrypt.length % 8 != 0) {
      Uint8List padded = Uint8List(encrypt.length + 8 - (encrypt.length % 8));
      for (int i = 0; i < encrypt.length; i++) {
        padded[i] = encrypt[i];
      }
      return padded;
    }
    return encrypt;
  }

//  /**
//   * @return
//   */
//  public static byte[] padding(byte[] encrypt) {
//  if (encrypt == null || encrypt.length == 0) {
//  return encrypt;
//  }
//
//  // not a multiple of 8
//  if (encrypt.length % 8 != 0) {
//  //create a new array with a size which is a multiple of 8
//  byte[] padded = new byte[encrypt.length + 8 - (encrypt.length % 8)];
//
//  //copy the old array into it
//  System.arraycopy(encrypt, 0, padded, 0, encrypt.length);
//  encrypt = padded;
//  }
//  return encrypt;
//  }
}
