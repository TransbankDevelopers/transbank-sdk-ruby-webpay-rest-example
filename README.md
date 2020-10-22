# Proyecto de ejemplo para uso de Webpay REST con el SDK de Transbank para Ruby

El siguiente proyecto es un simple sitio web el cual permite utilizar los diferentes productos y modalidades de Webpay disponibles en el
SDK de Transbank para Ruby.

## Requerimientos
Para ejecutar el proyecto es necesario tener: 
 ```docker``` y ```docker-compose``` ([como instalar Docker](https://docs.docker.com/install/))

## Correr servidor con Docker

El siguiente comando invocará lo necesario para levantar el entorno

```
make start
```

### Otros comandos

#### Generar un build

```
make build
```

#### Levantar servidor

```
make start
// O iniciarlo en modo headless
make start-headless
```

#### Detener

```
make stop
```

#### Dar de baja

```
make clean
```

El proyecto se ejecutará en http://localhost:3000 (y fallará en caso de que el puerto 3000 no esté disponible)

## Versiones

Este proyecto está hecho en Ruby `2.5.1` utilizando Rails `5.1.7`

