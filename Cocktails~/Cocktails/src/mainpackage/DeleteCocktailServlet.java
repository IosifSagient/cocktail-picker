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
import java.util.List;

/**
 * Servlet implementation class mainpackage.CocktailServlet
 */
@MultipartConfig
@WebServlet("/DeleteCocktailServlet")
/* RUNS WHEN ADMIN CLICKS DELETE BUTTON FROM "admin_drinks_page.jsp" */
public class DeleteCocktailServlet extends HttpServlet {

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCocktailServlet() {
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
        String name = request.getParameter("cocktailName");

        DatabaseProcedures dP = new DatabaseProcedures();
        String result = dP.deleteCocktail(name);

        response.setContentType("text/plain");
        response.getWriter().print(result);
        response.setHeader("Refresh", "3;url=adminsIndex.jsp");
    }
}
