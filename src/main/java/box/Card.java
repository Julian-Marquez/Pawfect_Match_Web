package box;

import java.sql.Date;
import java.time.LocalDate;

public class Card {
	private String cvv;
	private LocalDate expiry;
	private String cardType;
	private String cardNumber;
	private String cardHolderName;
	private long card_id;
	
	public Card(String cvv, LocalDate expiry,String cardType, String cardNumber, String cardHolderName) {
		this.cvv = cvv;
		this.expiry = expiry;
		this.cardType = cardType;
		this.cardNumber = cardNumber;
		this.cardHolderName = cardHolderName;
	}
	public String getCvv() {
		return this.cvv;
	}
	public LocalDate getExpiry() {
		return this.expiry;
	}
	public String getCardType() {
		return this.cardType;
	}
	public String getCardNumber() {
		return this.cardNumber;
	}
	public String getCardHolderName() {
		return this.cardHolderName;
	}
	public void setPaymentId(long id) {
		this.card_id =id;
	}
	
	public long getPaymentId() {
		return this.card_id;
	}
}
