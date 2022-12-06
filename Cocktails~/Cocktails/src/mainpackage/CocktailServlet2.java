package mainpackage;

import mainpackage.datapackage.Cocktails;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet implementation class mainpackage.CocktailServlet
 */
@WebServlet("/CocktailServlet2")
/* RUNS WHEN ADMIN CHOOSES A COCKTAIL FROM "admin_drinks_page.jsp" */
public class CocktailServlet2 extends HttpServlet {

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CocktailServlet2() {
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

        String name = request.getParameter("Name");

        Cocktails cocktailsList = dP.getCocktailN(name);

        request.setAttribute("cocktailsList", cocktailsList);
        request.getRequestDispatcher("cocktail_page.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
