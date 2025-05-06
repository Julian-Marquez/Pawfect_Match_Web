package box;

import java.time.LocalDate;
import java.util.*;

public class Animal {
	
	private String name;
	private String breed;
	private String description;
	private int age;
	private LocalDate datefound;
	private User owner; 
	private long animalId;
	private List<byte[]> images;
	
	
	public Animal(String name ,String breed,String des, int age ,LocalDate datefound) {
		this.breed = breed;
		this.name = name;
		this.age = age;
		this.description = des;
		this.datefound = datefound;
		images = new ArrayList<>();
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return this.name;
	}
	
	public void setAge(int age) {
		this.age  = age;
	}
	public int getAge() {
		return this.age;
	}

	public void setDateFound(LocalDate date) {
		this.datefound = date;
	}
	
	public LocalDate getDateFound() {
		return this.datefound;
	}
	
	
	public List<byte[]> getImages() {
		return this.images;
	}
	
	public void setBreed(String breed) {
		this.breed = breed;
	}
	
	public String getBreed() {
		return this.breed;
	}
	
	public void setOwner(User owner) {
		this.owner = owner;
	}
	
	public User getOwner() {
		return this.owner;
	}
	
	public void setAnimalId(long id) {
		this.animalId = id;
	}
	
	public long getAnimalId() {
		return this.animalId;
	}
	
	public void setDescription(String des){
		this.description = des;
		}
	
	public String getDescription() {
		return this.description;
	}
}
