package box;

import java.util.ArrayList;
import java.util.List;

public class Product {

    private String name;
    private String description;
    private int amount;
    private double price;
    private List<byte[]> productImages;
    private long productId;

    // Constructor to initialize Product with all fields
    public Product(String name, String description, int amount, double price) {
        this.name = name;
        this.description = description;
        this.amount = amount;
        this.price = price;
        this.productImages = new ArrayList<>();
    }

    // Getter and setter methods
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    public List<byte[]> getImages(){
    	return this.productImages;
    }
    public void setProductId(long id) {
    	this.productId = id;
    }
    public long getProductId() {
    	return this.productId;
    }
}
