package mainpackage.datapackage;

public class Users {

	private String username, email, password, dateOfBirth, category;
    static int usersCounter;

    public Users(String username, String email, String password, String dateOfBirth, String category) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.dateOfBirth = dateOfBirth;
        this.category = category;
        usersCounter++;
    }

    public Users(String category) {
    	usersCounter++;
    	this.category = category;
    };

    public Users() {
    	usersCounter++;
    	System.out.println("User has been created successfully!");
    }

    //Getters
    public String getUsername() { return username; }

    public String getEmail() { return email; }

    public String getPassword() { return password; }

    public String getDateOfBirth() { return dateOfBirth; }

    public String getCategory() { return category; }

    public int getUsersCounter() { return usersCounter; }

    //Setters
    public void setUsername(String username) { this.username = username; }

    public void setEmail(String email) { this.email = email; }

    public void setPassword(String password) { this.password = password; }

    public void setDateOfBirth(String dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public void setCategory(String category) { this.category = "User"; }

    //Login
    public void Login() { System.out.println("You have logged in successfully!"); }

    //Register
    public void Register() { System.out.println("Your registration is completed successfully!"); }

    //Logout
    public void Logout() { System.out.print("You have logged out!"); }

    public boolean isEmailValid(String em) {
    	String pattern = "^[A-Za-z][A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    	try { return em.matches(pattern);}
    	catch (NullPointerException e) { return false;}
    }
}

