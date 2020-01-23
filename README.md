# Proyecto de ejemplo para uso de Webpay REST con el SDK de Transbank para Ruby

El siguiente proyecto es un simple sitio web el cual permite utilizar los diferentes productos y modalidades de Webpay disponibles en el
SDK de Transbank para Ruby.

## Requerimientos
Para ejecutar el proyecto es necesario tener: 
 ```docker``` y ```docker-compose``` ([como instalar Docker](https://docs.docker.com/install/))

## Ejecutar ejemplo
Con el código fuente del proyecto en tu computador, puedes ejecutar en la raíz del proyecto el comando para construir el contenedor docker, si es la primera vez que ejecutas el proyecto:

Correr el proyecto de ejemplo e instalar las dependencias
```
make
```

El proyecto se ejecutará en http://localhost:3000 (y fallará en caso de que el puerto 3000 no esté disponible)

Este proyecto está hecho en Ruby 2.5.1 utilizando Rails 5.1.7

