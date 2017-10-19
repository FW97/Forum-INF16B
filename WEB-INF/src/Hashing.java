package de.dhbw.StudentForum;


import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.xml.bind.DatatypeConverter;

/**
 * Abstract class to hash passwords using a pseudo-random salt
 * @author Micha Spahr
 *
 */
public abstract class Hashing {
	
	private static final int HASH_BYTE_SIZE = 512; 
	private static final int SALT_BYTE_SIZE = 64;
	private static final int PBKDF2_ITERATIONS = 1000; 
	
	/**
	 * Generates pseudo random salt
	 * @return Generated salt
	 */
	private static byte[] generateSalt(){
		
		SecureRandom sr = new SecureRandom();
        byte[] salt = new byte[SALT_BYTE_SIZE];
        sr.nextBytes(salt);
        return salt;
	}
	
	/**
	 * Hashes given password with given salt
	 * @param password Given password
	 * @param salt Given salt
	 * @return Hashed password as byte[]
	 */
	private static byte[] hashPassword(String password, String salt){
		
		PBEKeySpec spec = null;
		SecretKeyFactory skf;
		byte[] hash = null;
		
		try{
			spec = new PBEKeySpec(password.toCharArray(), salt.getBytes("UTF-8"), PBKDF2_ITERATIONS, HASH_BYTE_SIZE);
			skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA512");
			hash = skf.generateSecret(spec).getEncoded();
		}catch (NoSuchAlgorithmException e) {
			System.err.println("Hash Algorithm not found / not supported");
			e.printStackTrace();
		}catch (InvalidKeySpecException ex) {
			System.err.println("KeySpec is not valid");
			ex.printStackTrace();
		}catch (UnsupportedEncodingException ey){
			System.err.println("Encoding from getBytes is not supported");
			ey.printStackTrace();
		}

		return hash;
	}
	
	/**
	 * Method to retrieve the hashed password with given salt
	 * @param password Given password
	 * @param salt Given salt
	 * @return Hashed password as String
	 */
	public static String getHashedPassword(String password, String salt){
		
		return DatatypeConverter.printBase64Binary(hashPassword(password, salt));
	}
	
	/**
	 * Generate a random salt and hash the given password for a new user
	 * @param password Given password
	 * @return Hashed password and salt as String[]
	 */
	public static String[] hashNewUser(String password){
		
		String[] saltAndHash = new String[2];
		
		saltAndHash[0] = DatatypeConverter.printBase64Binary(generateSalt());
		saltAndHash[1] = DatatypeConverter.printBase64Binary(hashPassword(password, saltAndHash[0]));
		
		return saltAndHash;
	}
}
