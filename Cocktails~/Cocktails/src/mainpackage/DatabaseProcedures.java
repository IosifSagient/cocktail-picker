package mainpackage;

import java.awt.image.BufferedImage;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import mainpackage.datapackage.Cocktails;
import mainpackage.datapackage.Users;

public class DatabaseProcedures { // DAO

	private final String url = "jdbc:postgresql://localhost:5432/Cocktails";
	private final String user = "postgres";
	private final String password = "anna123";
	private final String dbDriver = "org.postgresql.Driver";

	public DatabaseProcedures() {
	}

	public void loadDriver(String dbDriver) {
		try {
			Class.forName(dbDriver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	private Connection getConnection() {
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}

	public String insertUser(Object user) {

		this.loadDriver(dbDriver);
		Connection connection = this.getConnection();
		String result = "User has been inserted successfully!";
		String query = "INSERT INTO users(username, email, password, dateofbirth, category) VALUES (?, ?, ?, ?, ?);";

		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, ((Users) user).getUsername());
			ps.setString(2, ((Users) user).getEmail());
			ps.setString(3, ((Users) user).getPassword());
			ps.setString(4, ((Users) user).getDateOfBirth());
			ps.setString(5, ((Users) user).getCategory());

			ps.executeUpdate();
			ps.close();
			connection.close();
		} catch (SQLException e) {
			result = "User insertion failed! \r\nCheck the database connection or check if there is already a client with the same email!";
			e.printStackTrace();
		}
		return result;
	}

	public boolean loginValidation(String email, String password) {

		this.loadDriver(dbDriver);
		Connection connection = this.getConnection();
		boolean result = false;
		String query = "SELECT email, password FROM users WHERE email = ?";

		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, email);
			ResultSet resultSet = ps.executeQuery();

			if (resultSet.next()) {
				String pass = resultSet.getString("password");
				if (pass.equals(password)) {
					result = true;
				} else {
					result = false;
				}
			} else {
				result = false;
			}

			ps.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public String getUsername(String email) {

		this.loadDriver(dbDriver);
		Connection connection = this.getConnection();
		String result = "";
		String query = "SELECT email, username FROM users WHERE email = ?";

		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, email);
			ResultSet resultSet = ps.executeQuery();

			if (resultSet.next()) {
				result = resultSet.getString("username");
			} else {
				result = "Failed";
			}

			ps.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public String getUserCategory(String email) {

		this.loadDriver(dbDriver);
		Connection connection = this.getConnection();
		String result = "";
		String query = "SELECT email, category FROM users WHERE email = ?";

		try {
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, email);
			ResultSet resultSet = ps.executeQuery();

			if (resultSet.next()) {
				result = resultSet.getString("category");
			} else {
				result = "Failed";
			}

			ps.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public Cocktails getCocktail(String base, String taste, String ingredients) {

		String name = "", link = "";
		this.loadDriver(dbDriver);
		Connection connection = this.getConnection();
		PreparedStatement ps;
		ResultSet resultSet;
		Cocktails cocktail = new Cocktails(base, taste, ingredients);

		try {
			String query1 = "SELECT name, link FROM recipes WHERE base = ? AND taste = ?;";

			ps = connection.prepareStatement(query1);  //Get name and link from database/table recipes.
			ps.setString(1, base);
			ps.setString(2, taste);
			//ps.setString(3, ingredients);
			resultSet = ps.executeQuery();

			if ( resultSet.next() ) {
				name = resultSet.getString("name");
				cocktail.setName(name);
				link = resultSet.getString("link");
				cocktail.setLink(link);
			}

			resultSet.close();
			ps.close();
			connection.close();
			return cocktail;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public Cocktails getCocktailN(String name) {

		this.loadDriver(dbDriver);
		Connection connection = this.getConnection();
		PreparedStatement ps;
		ResultSet resultSet;
		Cocktails cocktail = new Cocktails(name, "", "", "", "", null);

		try {
			String query1 = "SELECT base, taste, link FROM recipes WHERE name = ?;";

			ps = connection.prepareStatement(query1);  //Get everything from database/table recipes for specific cocktail.
			ps.setString(1, name);
			resultSet = ps.executeQuery();

			if (resultSet.next()) {
				String base = resultSet.getString("base");
				cocktail.setBase(base);
				String taste = resultSet.getString("taste");
				cocktail.setTaste(taste);
				String link = resultSet.getString("link");
				cocktail.setLink(link);
			}
			resultSet.close();
			ps.close();

			//cocktail = Cocktails(name, base, taste, ingredients, link);

			connection.close();
			return cocktail;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<Cocktails> getCocktails(String base) {

		this.loadDriver(dbDriver);
		Connection connection = this.getConnection();
		PreparedStatement ps;
		ResultSet resultSet;
		String query = "SELECT * FROM recipes WHERE base = ?;";
		List<Cocktails> cocktailsList = new ArrayList<Cocktails>();

		try {
			ps = connection.prepareStatement(query);
			ps.setString(1, base);
			resultSet = ps.executeQuery();

			while ( resultSet.next() ) {
				String name = resultSet.getString("name");
				String taste = resultSet.getString("taste");
				String link = resultSet.getString("link");
				byte[] image = resultSet.getBytes("image");
				String encoded = Base64.getEncoder().encodeToString(image);

				Cocktails c = new Cocktails(name, base, taste, "", link, encoded);
				cocktailsList.add(c);
			}
			resultSet.close();
			ps.close();
			connection.close();
			return cocktailsList;
		} catch (SQLException e) {
			e.printStackTrace();
			return cocktailsList;
		}
	}

	public String addCocktail(Cocktails cocktail, byte[] imageBytes) {

		this.loadDriver(dbDriver);
		Connection connection = this.getConnection();
		String result = "";
		String query = "INSERT INTO recipes(name, base, taste, ingredients, link, image) VALUES (?, ?, ?, 'NO', ?, ?);";

		try {
			PreparedStatement ps= connection.prepareStatement(query);
			ps.setString(1, cocktail.getName());
			ps.setString(2, cocktail.getBase());
			ps.setString(3, cocktail.getTaste());
			ps.setString(4, cocktail.getLink());
			ps.setBytes(5, imageBytes);

			ps.executeUpdate();
			ps.close();
			result += "Cocktail has been added successfully!";
			connection.close();
		} catch (SQLException e) {
			result += "Cocktail insertion failed! \r\nCheck the database connection or check if there is already a cocktail with the same name!";
			e.printStackTrace();
		}
		return result;
	}

	public String deleteCocktail(String name) {

		this.loadDriver(dbDriver);
		Connection connection = this.getConnection();
		String result = "";
		String query = "DELETE FROM recipes WHERE name = ?";

		try {
			PreparedStatement ps= connection.prepareStatement(query);
			ps.setString(1, name);

			ps.executeUpdate();
			ps.close();
			result += "Cocktail has been deleted successfully!";
			connection.close();
		} catch (SQLException e) {
			result += "Cocktail delete failed! \r\nCheck the database connection or try again!";
			e.printStackTrace();
		}
		return result;
	}

}
