package implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.RecensioneBean;
import dao.RecensioneDAO;

public class RecensioneImpl implements RecensioneDAO {
	private ArrayList<RecensioneBean> al;
	private Connection c;
	private final String INSERT_QUERY="insert into Recensione values(?,?,?)";
	
	public RecensioneImpl() {
		// TODO Auto-generated constructor stub
		al=new ArrayList<RecensioneBean>();
		c=Connessione.setConnection();
		this.fillList();
	}
	
	private void fillList() {
		try {
			Statement s=c.createStatement();
			ResultSet rs=s.executeQuery("select * from Recensione");
			
			while(rs.next()) {
				al.add(new RecensioneBean(rs.getInt("numeroStelle"),rs.getString("codice_articoli"),rs.getString("id_utente"),rs.getString("titolo"),rs.getString("descrizione")));
			}
		}catch (SQLException e) {
			// TODO: handle exception
		}
	}

	public void stopConnection() {
		try {
			Connessione.releaseConnection(c);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void addRecensione(RecensioneBean rb) {
		// TODO Auto-generated method stub
		try(PreparedStatement ps=c.prepareStatement(INSERT_QUERY)){
			ps.setInt(1, rb.getNumeroStelle());
			ps.setString(2, rb.getIdUtente());
			ps.setString(3, rb.getCodiceArticolo());
			ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("error: "+e.getMessage());
		}
		al.add(rb);
	}

	@Override
	public void removeRecensione(RecensioneBean rb) {
		// TODO Auto-generated method stub
		try {
			Statement s=c.createStatement();
			s.executeUpdate("delete from Recensione where Recensione.id_utente='"+rb.getCodiceArticolo()+"' AND Recensione.codice_articoli='"+rb.getIdUtente()+"'");
		} catch (SQLException e) {
			// TODO: handle exception
		}finally {
			al.remove(rb);
		}
	}

	@Override
	public void updateRecensione(RecensioneBean oldRecensione, RecensioneBean newRecensione) {
		// TODO Auto-generated method stub
		try {
			Statement s=c.createStatement(),s1=c.createStatement();
			s.executeUpdate("delete from Recensione where Recensione.id_utente='"+oldRecensione.getCodiceArticolo()+"' AND Recensione.codice_articoli='"+oldRecensione.getIdUtente()+"'");
			s1.executeUpdate("insert into Recensione values('"+newRecensione.getNumeroStelle()+"','"+newRecensione.getIdUtente()+"','"+newRecensione.getCodiceArticolo()+"')");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public ArrayList<RecensioneBean> getAllRecensione() {
		// TODO Auto-generated method stub
		return al;
	}
	
	
}
