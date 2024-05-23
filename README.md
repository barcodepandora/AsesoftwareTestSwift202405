# ScotiaBankTest
App TMDB.
Por Juan Manuel Moreno Beltran {iOS native}

# Instrucciones
Al lanzar la app, dar opción "Comenzar".
Al escoger una categoría de resultados, se muestras resultados nuevos de búsqueda de acuerdo a la categoría.
Al escribir en el campo de texto, se muestras resultados nuevos de búsqueda de acuerdo al texto escrito.
Al dar swipe a la derecha se muestra una vista de filtros. Al tocar un filtro, se muestras resultados nuevos de búsqueda de acuerdo a los filtros (Microinteracciones.

# Arquitectura
Lineamientos de los principios Clean Architeture
[https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

Patrón de arquitectura MVVM principios SOLID
[https://medium.com/build-and-run/clean-architecture-en-ios-viper-893c8c3a75a4](https://medium.com/build-and-run/clean-architecture-en-ios-viper-893c8c3a75a4)

Model
TMDB | Movie
)))

Business Use Case
TMDBUseCase
)))

ViewModel
TMDBViewModel 
)))

View
TMDBViewController
)))

Unit Test
UseCaseTest


# Issues

## Memoria
Agrupación de funcionalidades
Asignaciones con oeradores ternarios
Asignaciones haciendo uso de parámetros por defecto
Gestión de dada desde los casos de uso
Gestión de una clase unica de filtros
Aplicación SOLID Principio D

## Layouts
Uso de Autolayout en forma programática en vista de lista de películas.

# TODO

## Splash Delay
Hallar la forma de demorar el mostrar contenido después del splash.

## Device testing
En este momento no dispongo de una cuenta de Apple Developer activa para hacer pruebas con device para permisos y memory leaks con Instruments
