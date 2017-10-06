import static org.junit.Assert.*;

import org.junit.Test;

/**
 * Test Class for Hashing.java to make sure that there are no          
 * @author Micha Spahr
 *
 */
public class Hashing_Test {

	@Test
	public void test() {
		
		String password = "M31n P4ssw0rt!=)#++";
		
		// Create random salt and derive hash from that with the given password
		String[] hashNewUser = Hashing.hashNewUser(password);
		
		System.out.println("Password: " + password);
		System.out.println("Hash: " + hashNewUser[1]);
		System.out.println("Salt: " + hashNewUser[0]);
		
		// Validate the hash with the correct password
		String getHashedPasswordCorrect = Hashing.getHashedPassword("M31n P4ssw0rt!=)#++", hashNewUser[0]);
		
		System.out.println("Hash correct pw: " + getHashedPasswordCorrect);
		
		// Check that hashing the wrong password will fail
		String getHashedPasswordWrong = Hashing.getHashedPassword("Passwort123", hashNewUser[0]);
		
		System.out.println("Hash wrong pw: " + getHashedPasswordWrong);
		
		// Check if correct password equals in the stored hash
		assertTrue(hashNewUser[1].equals(getHashedPasswordCorrect));
		
		// Make sure the wrong password does not equal the stored hash
		assertTrue(!hashNewUser[1].equals(getHashedPasswordWrong));
	}
}
