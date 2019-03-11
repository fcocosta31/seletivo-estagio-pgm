package seletivo_pgm.entity;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class GeraMD5 {
	public static String getMD5(String data) {

		MessageDigest m;
		try {
			m = MessageDigest.getInstance("MD5");

			m.update(data.getBytes(),0,data.length());
			
			return new BigInteger(1, m.digest()).toString(data.length());

		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
