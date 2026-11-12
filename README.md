# Explorador de contenido aleatorio

Página web desarrollada en **ASP.NET Core MVC (.NET 10)** que consume **4 APIs públicas** con `fetch` + `async/await` y muestra su contenido en 4 tarjetas independientes con **Bootstrap 5**: una cita, la foto de un perro, la foto de un gato y un dato curioso. Cada tarjeta se actualiza por separado sin recargar la página.

**Materia:** Programación Web III — Ingeniería de Sistemas, UNIVALLE (Bolivia)

## Integrantes

- [Nombre 1]
- [Nombre 2]
- [Nombre 3]

## Requisitos

- [.NET SDK 10](https://dotnet.microsoft.com/download)
- Visual Studio 2022/2026 (carga de trabajo *ASP.NET y desarrollo web*) **o** Visual Studio Code
- Conexión a Internet (las APIs son externas)
- No usa base de datos ni login

## Ejecución

### Con Visual Studio
1. Abrir `ExploradorContenido.sln` con doble clic.
2. Presionar **F5** (o el botón ▶ *https*).
3. El navegador se abre en la página principal con las 4 tarjetas.

### Con la terminal (`dotnet run`)
```bash
cd ExploradorContenido
dotnet run
```
Abrir en el navegador la URL que muestra la consola (por ejemplo `http://localhost:5xxx`).

## APIs utilizadas

| Sección | Método | Endpoint | Campo usado |
|---|---|---|---|
| Citas | GET | `https://dummyjson.com/quotes/random` | `quote`, `author` |
| Perros | GET | `https://dog.ceo/api/breeds/image/random` | `message` (URL de la imagen) |
| Gatos | GET | `https://cataas.com/cat?json=true` | `id` / `_id` → `https://cataas.com/cat/{id}`; si no hay id, `url` |
| Datos curiosos | GET | `https://uselessfacts.jsph.pl/api/v2/facts/random?language=en` | `text` |

## Estructura relevante

```
explorador-contenido-aleatorio/
├── ExploradorContenido.sln
├── README.md
├── capturas/                              → evidencias
└── ExploradorContenido/
    ├── Program.cs                         → configuración MVC (sin BD ni login)
    ├── Controllers/HomeController.cs      → acción Index() que devuelve la vista
    ├── Views/Home/Index.cshtml            → 4 tarjetas Bootstrap
    ├── Views/Shared/_Layout.cshtml        → plantilla con Bootstrap 5
    ├── wwwroot/css/explorador.css         → estilos propios
    ├── wwwroot/js/explorador.js           → lógica fetch + async/await
    └── wwwroot/lib/bootstrap/             → Bootstrap 5.3
```

## Preguntas de reflexión

**a) ¿Qué es un endpoint y cuál utilizaste para cada API?**
Un endpoint es la dirección (URL + método HTTP) de un servicio a la que se envía una petición para obtener un recurso. Usé: `GET https://dummyjson.com/quotes/random` (citas), `GET https://dog.ceo/api/breeds/image/random` (perros), `GET https://cataas.com/cat?json=true` (gatos) y `GET https://uselessfacts.jsph.pl/api/v2/facts/random?language=en` (datos curiosos). Están como constantes al inicio de `explorador.js`.

**b) ¿Qué diferencia existe entre recibir JSON y recibir directamente una imagen?**
El JSON es texto con datos estructurados que se convierte en objeto con `response.json()` para leer sus campos (por ejemplo `message` o `id`). Una imagen es un archivo binario: no se puede convertir a JSON, solo se muestra poniendo su URL en el `src` de un `<img>`. Por eso con cataas pido `/cat?json=true` (JSON con el `id`) y armo la URL `https://cataas.com/cat/{id}` para la imagen, en lugar de hacer `response.json()` sobre `/cat`.

**c) ¿Qué función cumplen `await` y `response.json()`?**
`await` pausa la función `async` hasta que la promesa termine (la respuesta del servidor llega) sin bloquear la página. `response.json()` lee el cuerpo de la respuesta y lo convierte en un objeto JavaScript; también devuelve una promesa, por eso en `consultarJson()` se usa `await respuesta.json()`.

**d) ¿Por qué se debe verificar `response.ok` además de usar `try/catch`?**
`fetch` solo lanza error cuando falla la red (sin Internet, DNS, CORS). Si el servidor responde 404 o 500, la promesa se resuelve normalmente y `catch` no se ejecuta. Por eso en `consultarJson()` reviso `if (!respuesta.ok)` y lanzo un `Error`, para que esos casos también lleguen al `catch` y se muestre el mensaje en la tarjeta.

**e) ¿Cómo lograste actualizar una sección sin recargar toda la página?**
Cada botón tiene un `addEventListener('click', ...)` que llama a su propia función async (`obtenerCita`, `obtenerPerro`, `obtenerGato`, `obtenerDatoCurioso`). Esa función pide los datos con `fetch` y cambia solo los elementos de su tarjeta (`textContent` o `src`) mediante el DOM. Los botones son `type="button"`, así que no envían ningún formulario ni recargan la página.

## Capturas

### Las 4 secciones funcionando
![Funcionando](capturas/funcionando.png)

### Error controlado (sin conexión)
![Error controlado](capturas/error.png)
