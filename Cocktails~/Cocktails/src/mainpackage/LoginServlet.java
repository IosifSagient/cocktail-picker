package mainpackage;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mainpackage.DatabaseProcedures;

/**
 * Servlet implementation class mainpackage.LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
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
    public LoginServlet() {
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
		 	String email = request.getParameter("Email");
		 	/*SecureRandom random = new SecureRandom();
			byte bytes[]= new byte[20];
			random.nextBytes(bytes);
			String password = getHash(request.getParameter("Password"),random.toString());*/
			String password = request.getParameter("Password");

	        HttpSession session = request.getSession();

	        DatabaseProcedures dP = new DatabaseProcedures();
	        response.setContentType("text/plain");

	        if (dP.loginValidation(email, password)) {
	            session.setAttribute("Email", email);
	            String username = dP.getUsername(email);
	            session.setAttribute("Username", username);
	            String category = dP.getUserCategory(email);
	            session.setAttribute("Category", category);

	    		if(category.equals("User")) {
	    			response.getWriter().print("Login Successfull!");
	    			response.setHeader("Refresh", "3;url=mainIndex.jsp");
	    		}
	    		else if(category.equals("Admin")){
	    			response.getWriter().print("Login Successfull!");
	            	response.setHeader("Refresh", "3;url=adminsIndex.jsp");
	    		}
	        }else{
	        	response.getWriter().print("Login Failed!");
	        	response.setHeader("Refresh", "3;url=login.jsp");
	        }
	}

}
