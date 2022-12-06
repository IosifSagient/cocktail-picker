package mainpackage;

import mainpackage.datapackage.Cocktails;
import org.apache.commons.io.IOUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;

/**
 * Servlet implementation class mainpackage.CocktailServlet
 */
@MultipartConfig
@WebServlet("/AddCocktailServlet")
/* RUNS WHEN ADD COCKTAIL FORM FROM ADMIN'S INDEX IS SUBMITTED */
public class AddCocktailServlet extends HttpServlet {

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCocktailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String base = request.getParameter("Base");
        String taste = request.getParameter("Taste");
        String name = request.getParameter("Name");
        String link = request.getParameter("Link");
        Part filePart = request.getPart("Image");
        InputStream fileContent = filePart.getInputStream();
        byte[] imageBytes = IOUtils.toByteArray(fileContent);

        Cocktails cocktail = new Cocktails(name, base, taste, "", link, null);

        DatabaseProcedures dP = new DatabaseProcedures();
        String result = dP.addCocktail(cocktail, imageBytes);
        response.setContentType("text/plain");
        response.getWriter().print(result);
        response.setHeader("Refresh", "3;url=adminsIndex.jsp");
    }
}
