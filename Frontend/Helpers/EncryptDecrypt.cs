using System.Security.Cryptography;
using System.Text.RegularExpressions;

namespace StudentAttendanceAPI.Helpers
{
    public static class EncryptDecrypt
    {
        private static readonly string EncryptionKey = "jB2Um4C9m9nWZnMu9Qc8pbCKwMX9JDPCuf0+TOxH+VI="; // Base64-encoded 256-bit key
        private static readonly string IV = "3Uz4u8vYJ5YZ+pYk6Fbimw=="; // Base64-encoded 128-bit IV (16 bytes)

        /// <summary>
        /// Encrypt
        /// </summary>
        /// <param name="plainText"></param>
        /// <returns></returns>
        public static string Encrypt(string plainText)
        {
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Convert.FromBase64String(EncryptionKey);
                aesAlg.IV = Convert.FromBase64String(IV);

                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

                using (MemoryStream msEncrypt = new MemoryStream())
                using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                {
                    swEncrypt.Write(plainText);
                    swEncrypt.Close();
                    return Convert.ToBase64String(msEncrypt.ToArray());
                }
            }
        }

        /// <summary>
        /// Decrypt
        /// </summary>
        /// <param name="encryptedText"></param>
        /// <returns></returns>
        public static string Decrypt(string encryptedText)
        {
            try
            {
                if (!IsBase64String(encryptedText))
                    throw new FormatException("The provided encrypted text is not valid Base64.");

                using (Aes aesAlg = Aes.Create())
                {
                    aesAlg.Key = Convert.FromBase64String(EncryptionKey);
                    aesAlg.IV = Convert.FromBase64String(IV);

                    ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);
                    byte[] buffer = Convert.FromBase64String(encryptedText);

                    using (MemoryStream msDecrypt = new MemoryStream(buffer))
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                    {
                        return srDecrypt.ReadToEnd();
                    }
                }
            }
            catch (FormatException ex)
            {
                Console.WriteLine("Decryption failed: Invalid Base64 string.");
                throw;
            }
            catch (CryptographicException ex)
            {
                Console.WriteLine("Decryption failed: Cryptographic error.");
                throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Decryption failed: " + ex.Message);
                throw;
            }
        }

        /// <summary>
        /// Base 64 String
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        private static bool IsBase64String(string s)
        {
            if (string.IsNullOrWhiteSpace(s))
                return false;

            s = s.Trim();
            return s.Length % 4 == 0 && Regex.IsMatch(s, @"^[a-zA-Z0-9\+/]*={0,2}$");
        }
    }
}
