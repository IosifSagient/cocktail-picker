package mainpackage;

import mainpackage.datapackage.Cocktails;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class mainpackage.CocktailServlet
 */
@WebServlet("/CocktailServlet")
/* RUNS WHEN COCKTAIL PICKER FORM FROM MAIN INDEX IS SUBMITTED */
public class CocktailServlet extends HttpServlet {

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CocktailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        HttpSession session = request.getSession(true);
        DatabaseProcedures dP = new DatabaseProcedures();

        String base = request.getParameter("Base");
        String taste = request.getParameter("Taste");
        String ingredients = "";

        Cocktails cocktailsList = dP.getCocktail(base, taste, ingredients);

        request.setAttribute("cocktailsList", cocktailsList);
        request.getRequestDispatcher("cocktail_page.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        DatabaseProcedures dP = new DatabaseProcedures();

        String name = request.getParameter("Name");

        Cocktails cocktail = dP.getCocktailN(name);

        request.setAttribute("cocktail", cocktail);
        request.getRequestDispatcher("cocktail_page.jsp").forward(request, response);
    }
}
