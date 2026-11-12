using System.Diagnostics;
using ExploradorContenido.Models;
using Microsoft.AspNetCore.Mvc;

namespace ExploradorContenido.Controllers
{
    public class HomeController : Controller
    {
        // Página principal: el contenido se carga en el navegador con fetch (explorador.js)
        public IActionResult Index()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
