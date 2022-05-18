package dao;

import java.util.ArrayList;

import bean.DatiAnagraficiBean;

public interface DatiAnagraficiDAO {
	public ArrayList<DatiAnagraficiBean> DatiAnagrafici = new ArrayList<DatiAnagraficiBean>();

	public void addDatiAnagrafici(DatiAnagraficiBean dab);

	public void removeDatiAnagrafici(DatiAnagraficiBean dab);

	public void updateDatiAnagrafici(DatiAnagraficiBean oldDab, DatiAnagraficiBean newDab);

	public ArrayList<DatiAnagraficiBean> getAllDatiAnagrafici();
}
