// ============================================================
// Explorador de contenido aleatorio
// Consume 4 APIs públicas con fetch + async/await.
// Cada sección se actualiza de forma independiente.
// ============================================================
'use strict';

// ---------- Endpoints de las APIs ----------
const URL_API_CITAS = 'https://dummyjson.com/quotes/random';
const URL_API_PERROS = 'https://dog.ceo/api/breeds/image/random';
const URL_API_GATOS = 'https://cataas.com/cat?json=true'; // con ?json=true devuelve JSON, no la imagen
const URL_BASE_GATOS = 'https://cataas.com';
const URL_API_DATOS = 'https://uselessfacts.jsph.pl/api/v2/facts/random?language=en';

// Referencias a los elementos de cada sección (se llenan al cargar la página)
const secciones = {};

// ============================================================
// Funciones auxiliares reutilizables
// ============================================================

/**
 * Hace una petición GET y devuelve el JSON.
 * Lanza un error si la respuesta HTTP no es correcta (response.ok = false).
 */
async function consultarJson(url) {
    // cache: 'no-store' obliga a que cada clic haga una consulta nueva
    const respuesta = await fetch(url, { cache: 'no-store' });

    if (!respuesta.ok) {
        throw new Error(`El servidor respondió con el estado HTTP ${respuesta.status}`);
    }

    return await respuesta.json();
}

/**
 * Muestra u oculta el mensaje de estado de una sección.
 * tipo: 'cargando' | 'error' | '' (vacío = ocultar)
 */
function mostrarEstado(seccion, mensaje, tipo) {
    seccion.estado.textContent = mensaje;
    seccion.estado.classList.remove('d-none', 'text-danger', 'text-secondary');

    if (!mensaje) {
        seccion.estado.classList.add('d-none');
    } else if (tipo === 'error') {
        seccion.estado.classList.add('text-danger');
    } else {
        seccion.estado.classList.add('text-secondary');
    }
}

/**
 * Activa o desactiva el estado de carga de una sección:
 * deshabilita el botón y muestra "Cargando…" mientras dura la consulta.
 */
function establecerEstadoCarga(seccion, cargando) {
    seccion.boton.disabled = cargando;
    seccion.contenedor.setAttribute('aria-busy', String(cargando));

    if (cargando) {
        seccion.contenido.classList.add('d-none'); // oculta el contenido anterior
        mostrarEstado(seccion, 'Cargando…', 'cargando');
    }
}

/** Muestra el contenido de la sección y oculta el mensaje de estado. */
function mostrarContenido(seccion) {
    mostrarEstado(seccion, '', '');
    seccion.contenido.classList.remove('d-none');
}

/** Muestra un mensaje de error comprensible en la tarjeta. */
function mostrarError(seccion, descripcion, error) {
    console.error(`[${descripcion}]`, error); // detalle técnico solo en la consola

    const causa = navigator.onLine
        ? 'El servicio no respondió correctamente.'
        : 'Parece que no hay conexión a Internet.';

    seccion.contenido.classList.add('d-none');
    mostrarEstado(seccion, `No se pudo cargar ${descripcion}. ${causa} Presiona el botón para reintentar.`, 'error');
}

/**
 * Carga una imagen en la sección. Maneja onload y onerror de la etiqueta <img>.
 */
function mostrarImagen(seccion, urlImagen, textoAlternativo, descripcion) {
    const imagen = seccion.imagen;

    mostrarEstado(seccion, 'Cargando imagen…', 'cargando');

    // Cuando la imagen termina de descargarse, se muestra
    imagen.onload = () => mostrarContenido(seccion);

    // Si la URL no se puede cargar, se muestra un mensaje en la tarjeta
    imagen.onerror = () => {
        seccion.contenido.classList.add('d-none');
        mostrarEstado(seccion, `La imagen ${descripcion} no se pudo mostrar. Presiona el botón para intentar con otra.`, 'error');
    };

    imagen.alt = textoAlternativo;
    imagen.src = urlImagen;
}

// ============================================================
// Una función async independiente por API
// ============================================================

/** 1) Citas — dummyjson. Respuesta: { id, quote, author } */
async function obtenerCita() {
    const seccion = secciones.cita;
    establecerEstadoCarga(seccion, true);

    try {
        const datos = await consultarJson(URL_API_CITAS);

        if (!datos.quote) {
            throw new Error('La respuesta no contiene una cita.');
        }

        seccion.texto.textContent = `“${datos.quote}”`;
        seccion.autor.textContent = datos.author || 'Autor desconocido';
        mostrarContenido(seccion);
    } catch (error) {
        mostrarError(seccion, 'la cita', error);
    } finally {
        establecerEstadoCarga(seccion, false); // se rehabilita el botón aunque haya error
    }
}

/** 2) Perros — dog.ceo. Respuesta: { message: "url de la imagen", status: "success" } */
async function obtenerPerro() {
    const seccion = secciones.perro;
    establecerEstadoCarga(seccion, true);

    try {
        const datos = await consultarJson(URL_API_PERROS);

        if (datos.status !== 'success' || typeof datos.message !== 'string') {
            throw new Error('La respuesta no contiene una imagen válida.');
        }

        mostrarImagen(seccion, datos.message, 'Fotografía aleatoria de un perro', 'del perro');
    } catch (error) {
        mostrarError(seccion, 'la imagen del perro', error);
    } finally {
        establecerEstadoCarga(seccion, false);
    }
}

/**
 * Construye la URL de la imagen del gato a partir del JSON.
 * cataas puede devolver "id" o "_id", y "url" absoluta o relativa.
 */
function construirUrlGato(datos) {
    const idGato = datos.id || datos._id;

    if (idGato) {
        return `${URL_BASE_GATOS}/cat/${encodeURIComponent(idGato)}`;
    }

    if (typeof datos.url === 'string' && datos.url.length > 0) {
        if (datos.url.startsWith('http')) {
            return datos.url; // URL absoluta
        }
        const separador = datos.url.startsWith('/') ? '' : '/';
        return `${URL_BASE_GATOS}${separador}${datos.url}`; // URL relativa
    }

    throw new Error('La respuesta no contiene id ni url de la imagen.');
}

/** 3) Gatos — cataas (JSON con id/_id y/o url) */
async function obtenerGato() {
    const seccion = secciones.gato;
    establecerEstadoCarga(seccion, true);

    try {
        // Se pide ?json=true; nunca se hace .json() sobre /cat porque devuelve la imagen directa
        const datos = await consultarJson(URL_API_GATOS);
        const urlImagen = construirUrlGato(datos);

        mostrarImagen(seccion, urlImagen, 'Fotografía aleatoria de un gato', 'del gato');
    } catch (error) {
        mostrarError(seccion, 'la imagen del gato', error);
    } finally {
        establecerEstadoCarga(seccion, false);
    }
}

/** 4) Datos curiosos — uselessfacts. Respuesta: { id, text, source, language, ... } */
async function obtenerDatoCurioso() {
    const seccion = secciones.dato;
    establecerEstadoCarga(seccion, true);

    try {
        const datos = await consultarJson(URL_API_DATOS);

        if (!datos.text) {
            throw new Error('La respuesta no contiene un dato curioso.');
        }

        seccion.texto.textContent = datos.text;
        mostrarContenido(seccion);
    } catch (error) {
        mostrarError(seccion, 'el dato curioso', error);
    } finally {
        establecerEstadoCarga(seccion, false);
    }
}

// ============================================================
// Inicialización
// ============================================================

/** Agrupa los elementos HTML de una sección según su prefijo de id. */
function obtenerElementosSeccion(prefijo) {
    return {
        contenedor: document.getElementById(`${prefijo}-zona`),
        estado: document.getElementById(`${prefijo}-estado`),
        contenido: document.getElementById(`${prefijo}-contenido`),
        boton: document.getElementById(`btn-${prefijo}`),
        texto: document.getElementById(`${prefijo}-texto`),
        autor: document.getElementById(`${prefijo}-autor`),
        imagen: document.getElementById(`${prefijo}-imagen`)
    };
}

document.addEventListener('DOMContentLoaded', () => {
    secciones.cita = obtenerElementosSeccion('cita');
    secciones.perro = obtenerElementosSeccion('perro');
    secciones.gato = obtenerElementosSeccion('gato');
    secciones.dato = obtenerElementosSeccion('dato');

    // Cada botón actualiza solo su sección, sin recargar la página
    secciones.cita.boton.addEventListener('click', obtenerCita);
    secciones.perro.boton.addEventListener('click', obtenerPerro);
    secciones.gato.boton.addEventListener('click', obtenerGato);
    secciones.dato.boton.addEventListener('click', obtenerDatoCurioso);

    // Carga inicial: las 4 consultas se lanzan en paralelo y son independientes
    obtenerCita();
    obtenerPerro();
    obtenerGato();
    obtenerDatoCurioso();
});
