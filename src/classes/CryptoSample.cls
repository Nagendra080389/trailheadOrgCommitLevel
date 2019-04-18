/**
 * Description of the class
 * <p /><p />
 * @author Nagendra Kumar Singh
 */
public class CryptoSample {
    public void Demo(){
        Blob bKey;
        String encryptedData;
        String decryptedData;
        String initialData = 'HCSCTest@123';

        // Working with keys...
        // Generate key ...
        bKey = GenerateAESKey(256);
        System.debug('BKey: ' + bKey);
        // but need the String version to save it...
        String sKey = KeyToString(bKey);
        System.debug('SKey: ' + sKey);
        // and the Blob version to use it...
        Blob b2 = keyFromString(sKey);
        //  OK, but make sure they are the same!
        System.assert(sKey == KeyToString(b2));

        // AES128
        bKey = GenerateAESKey(128);
        encryptedData = Encrypt('AES128', bKey, initialData);
        decryptedData = Decrypt('AES128', bKey, encryptedData);
        System.assertEquals(initialData, decryptedData);

        // AES192
        bKey = GenerateAESKey(192);
        encryptedData = Encrypt('AES192', bKey, initialData);
        decryptedData = Decrypt('AES192', bKey, encryptedData);
        System.assertEquals(initialData, decryptedData);

        // AES256
        bKey = GenerateAESKey(256);
        encryptedData = Encrypt('AES256', bKey, initialData);
        decryptedData = Decrypt('AES256', bKey, encryptedData);
        System.assertEquals(initialData, decryptedData);
    }

    private String Encrypt(String method, Blob bKey, String data) {
        System.debug('Encrypting: ' + Data);
        Blob bData = Blob.valueOf(data);
        Blob bEncrypted = Crypto.encryptWithManagedIV(method, bKey, bData);
        String output = EncodingUtil.base64Encode(bEncrypted);
        System.debug('Encrypted: ' + output);
        return output;
    }
    private String Decrypt(String method, Blob bKey, String secureData) {
        System.debug('Decrypting: ' + secureData);
        Blob bSecureData = EncodingUtil.base64Decode(secureData);
        Blob bData = Crypto.decryptWithManagedIV(method, bKey, bSecureData);
        String output = bData.toString();
        System.debug('Decrypted: ' + output);
        return output;
    }

    private Blob GenerateAESKey(Integer Size) {
        // Size values are 128, 192, 256
        return Crypto.generateAesKey(Size);
    }
    private String keyToString(Blob bKey) {
        return EncodingUtil.base64Encode(bKey);
    }
    private Blob keyFromString(String sKey) {
        return EncodingUtil.base64Decode(sKey);
    }
}