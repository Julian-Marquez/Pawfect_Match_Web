package box;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Receipt {
	private String name = "Pawfect Online Store";
	private LocalDate dateBought;
	private double subTotal;
	private ArrayList<Product> products;
	private long receiptId;
	private Card paymentMethod;
	
	public Receipt(double subTotal,List products,Card paymentMethod) {
		this.products = new ArrayList<Product>();
		this.products.addAll(products);
		this.subTotal = subTotal;
		this.paymentMethod = paymentMethod;
		this.dateBought =  LocalDate.now();
	}
	
	public void setPaymentMethod(Card payment) {
		this.paymentMethod = payment;
	}
	
	public double getSubTotal() {
		return this.subTotal;
	}
	
	public ArrayList<Product> getProducts(){
		return this.products;
	}
	
	public String getName() {
		return this.name;
	}
	
	public void setReceiptId(long id) {
		this.receiptId = id;
	}
	public long getReceiptId() {
		return this.receiptId;
	}
	
	public void setDate(LocalDate date) {
		this.dateBought = date;
		
	}
	
	public LocalDate getDateBought() {
		return this.dateBought;
	}
	
	public Card getPaymentMethod() {
		return this.paymentMethod;
	}

}
