package box;

import java.util.ArrayList;

public class User {
	private String firstname;
	private String lastname;
	private String email;
	private String password;
	private long idNumber;
	private byte[] profilePic;
	private ArrayList<Animal> favoritePets;
	private ArrayList<Animal> adoptionPets;
	private ArrayList<Product> cart;
	private ArrayList<Receipt> receipts;
	private ArrayList<Card> payments;

	
	public User(String fname,String lname,String email, String password) {
		this.firstname = fname;
		this.lastname = lname;
		this.email = email;
		this.password = password;
		this.adoptionPets = new ArrayList<>();
		this.favoritePets = new ArrayList<>();
		this.cart = new ArrayList();
		this.receipts = new ArrayList();
		this.payments =  new ArrayList();
	}
	
	public void setFirstname(String fname) {
		this.firstname = fname;
	}
	
	public String getFirstname() {
		return this.firstname;
	}
	
	public void setLastname(String Lname) {
		this.lastname = Lname;
	}
	
	public String getLastname() {
		return this.lastname;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmail() {
		return this.email;
	}
	
	public void setPasswrod(String password) {
		this.password = password;
	}
	public String getPassword() {
		return this.password;
	}
	public void setUserId(long id) {
		this.idNumber = id;
	}
	public long getUserId() {
		return this.idNumber;
	}
	public void setPrpfilePic(byte[] data) {
		this.profilePic = data;
	}
	public byte[] getProfilePic() {
		return this.profilePic;
	}
	
	public ArrayList<Animal> getAdoptionPets() {
		return this.adoptionPets;
	}
	public ArrayList<Animal> getFavoritePets(){
		return this.favoritePets;
	}
	public ArrayList<Product> getAllProducts(){
		return this.cart;
	}
	public ArrayList<Receipt> getAllReceipts(){
		return this.receipts;
	}
	public ArrayList<Card> getAllPayments(){
		return this.payments;
	}
	
}
