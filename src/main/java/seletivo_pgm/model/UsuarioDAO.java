package seletivo_pgm.model;

import org.hibernate.Session;
import org.hibernate.Transaction;

import seletivo_pgm.entity.Usuario;
import seletivo_pgm.factory.ConnectionFactory;

@SuppressWarnings("deprecation")
public class UsuarioDAO {
	
	private final Session session;
	
	public UsuarioDAO() {
		this.session = ConnectionFactory.getSessionFactory().openSession();
	}
	
	public void salvar(Usuario user) {
		Transaction tx = session.beginTransaction();
		this.session.save(user);
		tx.commit();
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Usuario auth(Usuario user) {
		String sql = "Select x from Usuario x where login = '"+user.getLogin()+"' and senha = '"+user.getSenha()+"'";
		return (Usuario) session.createQuery(sql).uniqueResult();
	}
}
