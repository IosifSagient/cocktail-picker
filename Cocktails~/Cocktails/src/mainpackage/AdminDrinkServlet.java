package mainpackage;

import mainpackage.datapackage.Cocktails;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Servlet implementation class mainpackage.CocktailServlet
 */
@WebServlet("/AdminDrinkServlet")
/* RUNS WHEN ADMIN CHOOSES A DRINK CATEGORY */
public class AdminDrinkServlet extends HttpServlet {

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDrinkServlet() {
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
        List<Cocktails> cocktailsList = dP.getCocktails(base);
        Collections.sort(cocktailsList, new Comparator<Cocktails>() {
            @Override
            public int compare(Cocktails o1, Cocktails o2) {
                return o1.getName().compareTo(o2.getName());
            }
        });

        request.setAttribute("cocktailsList", cocktailsList);
        request.setAttribute("Base", base);
        request.getRequestDispatcher("admin_drinks_page.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
