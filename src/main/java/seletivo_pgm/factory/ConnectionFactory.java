package seletivo_pgm.factory;

import org.hibernate.SessionFactory;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class ConnectionFactory {
	
	private static StandardServiceRegistry standardRegistry;
	private static Metadata metaData;
	private static final SessionFactory factory;
	
	public ConnectionFactory() {}
	
	static {
		try {
		standardRegistry = new StandardServiceRegistryBuilder().configure("hibernate.cfg.xml").build();
		metaData = new MetadataSources(standardRegistry).getMetadataBuilder().build();
		factory = metaData.getSessionFactoryBuilder().build();
		}catch (Throwable th) {

			System.err.println("FALHA AO CRIAR A SESSIONFACTORY INICIAL " + th);
			throw new ExceptionInInitializerError(th);

		}		
	}
	
	public static SessionFactory getSessionFactory() {
		return factory;
	}
	
}
