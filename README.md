# Proyecto de ejemplo para uso de Webpay REST con el SDK de Transbank para Ruby

El siguiente proyecto es un simple sitio web el cual permite utilizar los diferentes productos y modalidades de Webpay disponibles en el
SDK de Transbank para Ruby.

## Instalar dependencias en local

```
bundle install
```

## Correr en local

```
rails s
```

## Requerimientos con Docker
Para ejecutar el proyecto es necesario tener: 
 ```docker``` y ```docker-compose``` ([como instalar Docker](https://docs.docker.com/install/))

## Correr servidor con Docker

El siguiente comando invocará lo necesario para levantar el entorno

```
docker compose up
```

#### Dar de baja con Docker

```
docker compose down
```

El proyecto se ejecutará en http://localhost:3000 (y fallará en caso de que el puerto 3000 no esté disponible)

## Versiones

Este proyecto está hecho en Ruby `2.5.1` utilizando Rails `5.1.7`

## Notas
Se debe eliminar el archivo 'Gemfile.lock' si existen problemas