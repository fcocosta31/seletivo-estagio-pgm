package seletivo_pgm.model;

import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.Transaction;

import seletivo_pgm.entity.Cadastro;
import seletivo_pgm.entity.Cidade;
import seletivo_pgm.entity.Estado;
import seletivo_pgm.factory.ConnectionFactory;


@SuppressWarnings("deprecation")
public class CadastroDAO {
	
	private final Session session;
	
	public CadastroDAO() {
		this.session = ConnectionFactory.getSessionFactory().openSession();
	}
	
	@SuppressWarnings({ "unchecked" })
	public List<Cadastro> listar (){
		String sql = "select * from cadastro";				
		return session.createSQLQuery(sql).addEntity(Cadastro.class).list();		
	}

	@SuppressWarnings({ "unchecked" })
	public List<Cadastro> listarTodos (){
		String sql = "select * from cadastro order by ampla, nome";				
		return session.createSQLQuery(sql).addEntity(Cadastro.class).list();		
	}

	@SuppressWarnings({ "unchecked" })
	public List<Cadastro> listarInscritos (){
		String sql = "select * from cadastro where pago = 1 order by ampla, nome";				
		return session.createSQLQuery(sql).addEntity(Cadastro.class).list();		
	}
	
	public void salvar (Cadastro cadastro) {
		Transaction tx = session.beginTransaction();
		
		if(cadastro.getIsencao().equals("Portador"))
			cadastro.setAmpla(false);
		else
			cadastro.setAmpla(true);

		this.session.save(cadastro);
		tx.commit();
	}
	
	public void atualizar (Cadastro cadastro) {
		Transaction tx = session.beginTransaction();

		if(cadastro.getIsencao().equals("Portador"))
			cadastro.setAmpla(false);
		else
			cadastro.setAmpla(true);

		this.session.update(cadastro);
		tx.commit();		
	}
	
	public void deletar (Cadastro cadastro) {
		Transaction tx = session.beginTransaction();
		this.session.remove(cadastro);
		tx.commit();
	}
	
	@SuppressWarnings({ "unchecked" })
	public List<Cidade> listaCidades(String uf){
		
		String sql = "select * from cidade where uf = '"+uf+"'";
		
		return session.createSQLQuery(sql).addEntity(Cidade.class).list();
		
	}

	@SuppressWarnings({ "unchecked" })
	public List<Estado> listaEstados(){
		
		String sql = "select distinct uf from cidade order by uf";
		
		return session.createSQLQuery(sql).addEntity(Estado.class).list();
		
	}
	
	public Cadastro recupera(long id) {
		
		return session.get(Cadastro.class, id);
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Cadastro recupera(Long id, String cpf) {
		String sql = "select x from Cadastro x where id = "+id+" and cpf = '"+cpf+"'";
		return (Cadastro) session.createQuery(sql, Cadastro.class).uniqueResult();
	}
	
	
	public Cadastro recupera(String cpf) {		
		String sql = "select x from Cadastro x where cpf = :cpf";
		Cadastro cadastro = null;
		try {
		cadastro = session.createQuery(sql, Cadastro.class)
							.setParameter("cpf", cpf)
							.uniqueResult();
		}catch(NoResultException nre) {
			return null;
		}
		return cadastro;
	}
	
}
