package implementation;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.CapBean;
import bean.StandardBean;

public class StandardImpl {
	private Connection c;
	private ArrayList<StandardBean> al;
	
	public StandardImpl() {
		al=new ArrayList<StandardBean>();
		c=Connessione.setConnection();	
		this.fillList();
	}

	private void fillList() {
		try {
			Statement s=c.createStatement();
			ResultSet rs=s.executeQuery("select * from Cap");
			
			while(rs.next()) {
				int idSpedizione=rs.getInt(1);
				String numOrdine=rs.getString(2);
				Date dataSpedizione=rs.getDate(3);
				double costo=rs.getDouble(4);
				
				al.add(new StandardBean(idSpedizione,numOrdine,dataSpedizione,costo));
				
			}
		}catch(SQLException e) {
			e.printStackTrace();
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
}
