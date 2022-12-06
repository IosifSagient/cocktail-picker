package mainpackage;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mainpackage.datapackage.Users;

import static java.lang.Integer.parseInt;

/**
 * Servlet implementation class RegisterUserServlet
 */
@WebServlet("/RegisterUserServlet")
public class RegisterUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public String getHash(String unhashed, String salt) {
        // Hash the password.

        final String toHash = salt + unhashed + salt;
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException ex) {
            return "00000000000000000000000000000000";
        }
        messageDigest.update(toHash.getBytes(), 0, toHash.length());
        String hashed = new BigInteger(1, messageDigest.digest()).toString(16);
        if (hashed.length() < 32) {
            hashed = "0" + hashed;
        }
        return hashed.toUpperCase();
    }

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("Username");
		String email = request.getParameter("Email");
		/*SecureRandom random = new SecureRandom();
		byte bytes[]= new byte[20];
		random.nextBytes(bytes);
		String password = getHash(request.getParameter("Password"),random.toString());*/
		String password = request.getParameter("Password");
		String dateofbirth = request.getParameter("Birthday");
		String category = "User";

		String[] str = dateofbirth.split("-", 2);
		int date = parseInt(str[0]);

		HttpSession session = request.getSession(true);
		DatabaseProcedures dP = new DatabaseProcedures();

		// Check if user is over 18
		if (date < 2003) {
			Users user = new Users(username, email, password, dateofbirth, category);
			String result = dP.insertUser(user);
			response.setContentType("text/plain");
			response.getWriter().print(result);
			response.setHeader("Refresh", "3;url=mainIndex.jsp");
		} else {
			response.getWriter().print("Registration failed! You must be over 18 years old! :'( ");
			response.setHeader("Refresh", "3;url=register.jsp");
		}
	}
}
