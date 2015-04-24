# Formatos de los juegos y logs #
Al iniciarse un juego, esta carga un archivo GAME\_FILE donde se le especifican distintas opciones, asi como una lista de trials a utilizar.

La sintaxis del archivo GAME\_FILE es una 'lista'. (formato muy facil de manipular con python, javascript y flash).
Una lista es un conjunto de ITEM, encerrados entre corchetes, donde un ITEM a la vez puede ser una lista.

por ejemplo, esta es una lista de 3 items, cuyo tercer item es a la vez, una lista de 2 items.
ej: [ITEM, ITEM, [ITEM, ITEM]]

En la definicion del formato.


# Memoria #

## Formato del GAME\_FILE de memoria ##

### En el GAME\_FILE de un juego de memoria especificamos: ###
  * nivel\_inicial (_numero natural_):
    * Es el nivel en el que se empieza jugando.
    * **tiene** que haber al menos un trial de este nivel.
  * perdidas (_numero natural_):
    * La cantidad de veces consecutivas que uno debe perder antes de disminuir el nivel.
  * victorias (_numero natural_):
    * La cantidad de veces consecutivas que uno debe ganar antes de aumentar el nivel.
  * numero\_de\_trials (_numero natural_):
    * La cantidad de trials a jugar, luego de jugar esta cantidad, el juego termina.
  * trials (_lista de TRIAL_):
    * La lista de TRIAL disponibles para el juego.
    * Cuando el juego necesita un trial de un nivel en particular, elige al azar entre todos los TRIAL que tienen ese nivel.

### Un TRIAL es una lista con ###
  * nivel (_numero natural_):
    * El nivel de dificultad del trial.
  * agrupacion (_numero entero de 0 a 7 inclusive_):
    * 0 significa que no hay agrupamiento.
    * De no ser 0, el valor es el indice (contando desde 1) del elemento de la FICHA por el que agrupamos. ver la descripcion de FICHA para ver la correspondencia indice<>elemento.
  * fichas (_lista de CARD_):
    * La lista de CARD a usar para el trial.

### Un CARD, o ficha es una lista con... ###
  * marco (_numero entero de 1 a 12 inclusive_)
    * Siempre debe haber un marco
    * Es el marco a usar para la ficha, estos son los valores:
      1. Cuadrado con la esquina sup.der. redondeada _/res/svg/marcos/casiuncuadrado.svg_
      1. Circulo _/res/svg/marcos/circulo.svg_
      1. Nubecita _/res/svg/marcos/circulosss.svg_
      1. Cuadrado redondeado en todas las esquinas _/res/svg/marcos/cuadrado.svg_
      1. Cuadrado con las esquinas sup.der. e inf.izq. redondeadas _/res/svg/marcos/doble gota.svg_
      1. Cuadrado con las esquinas inf.der. e inf.izq. redondeadas _/res/svg/marcos/escudo.svg_
      1. Cuadrado con las esquinas sup.der. y sup.izq redondeadas _/res/svg/marcos/escudo2.svg_
      1. Estrella de 20 puntas _/res/svg/marcos/estrella.svg_
      1. Cuadrado con las esquinas inf.izq, sup.der. y sup.izq. redondeadas. _/res/svg/marcos/gota.svg_
      1. Estrella de 8 puntas _/res/svg/marcos/poligono.svg_
      1. Estrella de 8 puntas en la mitad superior, hexagono en la inferior _/res/svg/marcos/raro1.svg_
      1. Estrella de 8 puntas en la mitad superior, circulo en la inferior _/res/svg/marcos/raro2.svg_

  * fondo (_numero entero de 1 a 13 inclusive_):
    * siempre debe haber un fondo
    * Es el color o trama de fondo a usar en la ficha
      1. /res/svg/fondos/playa.svg
      1. /res/svg/fondos/azul.svg
      1. /res/svg/fondos/celeste.svg
      1. /res/svg/fondos/gris.svg
      1. /res/svg/fondos/marron.svg
      1. /res/svg/fondos/naranja.svg
      1. /res/svg/fondos/rojo.svg
      1. /res/svg/fondos/rosa.svg
      1. /res/svg/fondos/verde.svg
      1. /res/svg/fondos/violeta.svg
      1. /res/svg/fondos/amarillo.svg
      1. /res/svg/fondos/fucsia.svg
      1. /res/svg/fondos/marino.svg (celeste)

  * sombrilla (_numero entero de 0 a 12 inclusive_)
    * 0 significa que no hay sombrilla
    * valores:
      1. violeta _/res/svg/sombrillas/1.svg_
      1. fucsia _/res/svg/sombrillas/2.svg_
      1. verde _/res/svg/sombrillas/3.svg_
      1. marron _/res/svg/sombrillas/4.svg_
      1. celeste _/res/svg/sombrillas/5.svg_
      1. rosa _/res/svg/sombrillas/6.svg_
      1. naranja _/res/svg/sombrillas/7.svg_
      1. amarillo _/res/svg/sombrillas/8.svg_
      1. rojo _/res/svg/sombrillas/9.svg_
      1. rojo/naranja _/res/svg/sombrillas/10.svg_
      1. gris _/res/svg/sombrillas/11.svg_
      1. azul _/res/svg/sombrillas/12.svg_

  * baldes (_numero entero de 0 a 2 inclusive_)
    * 0 significa que no hay baldes
    * valores:
      1. 2 baldes _/res/svg/baldes/2.svg_
      1. 4 baldes _/res/svg/baldes/4.svg_

  * estrellas (_numero entero de 0 a 10 inclusive_)
    * El valor se corresponde con la cantida de estrellas mostradas
    * valores:
      1. _/res/svg/estrellas/1.svg_
      1. _/res/svg/estrellas/2.svg_
      1. _/res/svg/estrellas/3.svg_
      1. _/res/svg/estrellas/4.svg_
      1. _/res/svg/estrellas/5.svg_
      1. _/res/svg/estrellas/6.svg_
      1. _/res/svg/estrellas/7.svg_
      1. _/res/svg/estrellas/8.svg_
      1. _/res/svg/estrellas/9.svg_
      1. _/res/svg/estrellas/10.svg_

  * personaje (_numero entero de 0 a 3 inclusive_)
    * 0 significa que no hay personaje
    * valores:
      1. ana parada _/res/svg/personaje/anaparada.svg_
      1. ana sentada _/res/svg/personaje/anareposera.svg_
      1. ono parado _/res/svg/personaje/onoplaya.svg_

  * lentes (_numero entero de 0 a 1 inclusive_)<- jeje, o sea, 0 o 1
    * el archivo de los lentes es _/res/svg/lentes/lentes.svg_

### Notacion corta de un nivel de memoria ###
```
GAME_FILE = [nivel_inicial, perdidas, victorias, numero_de_trials, [TRIAL, TRIAL,...]]
TRIAL = [nivel, agrupacion, [FICHA, FICHA,...]]
FICHA = [marco, fondo, sombrilla, baldes, estrellas, personaje, lentes]
```

## Formato del LOG\_FILE de memoria ##
Una vez guardado el log crudo, se puede parsear para generar un LOG\_FILE, tambien en formato de listas anidadas. En el log simplemente unimos cada TRIAL con la respuesta correspondiente (RESPONSE).

### LOG\_FILE ###
  * responses (_lista de TRIAL\_RESPONSE_)

### TRIAL\_RESPONSE ###
  * TRIAL (el TRIAL original al que se da respuesta, mismo formato del GAME\_FILE)
  * RESPONSE (una lista RESPONSE, ver mas abajo)

### RESPONSE ###
  * correct (_numero entero 1 o 0_)
    * El resultado del trial, 1 si gano, 0 si repitio fichas.
  * choices (_lista de CHOICE_)
    * La lista de etapas en las que el jugador elige una ficha.

### CHOICE ###
  * card\_id(_numero entero_)
    * La ficha elegida en esta etapa, el valor es el indice de la ficha en el listado de fichas del TRIAL, contando desde 0.
  * last\_mouse (_\[x, mouse y\](mouse.md)_)
    * la ultima posicion del mouse, en una lista de [x,y] con precision de al menos 2 decimales.
  * moves (_lista de MOUSEMOVE_)
    * Una lista de todos los movimientos que se hicieron con el mouse durante esta etapa.
  * positions (_lista de CARD\_POS_)
    * La lista de posiciones de cada ficha para esta etapa.

### MOUSEMOVE ###
  * x (_numero, con minimo de 2 decimales_)
    * la posicion x de ese movimiento.
  * y (_numero, con minimo de 2 decimales_)
    * la posicion y de ese movimiento
  * time (_numero natural_)
    * los milisegundos desde el inicio del juego en los que ocurrio el movimiento

### CARD\_POS ###
  * x(_numero entero_):
    * la posicion x de la ficha
  * y(_numero entero_)
    * la posicion y de la ficha

### Notacion corta de un GAME\_LOG de memoria ###
```
GAME_LOG = [TRIAL_RESPONSE, TRIAL_RESPONSE, ...]
TRIAL_RESPONSE = [TRIAL, RESPONSE]
RESPONSE = [correct, [CHOICE, CHOICE, ...]]
CHOICE = [card_id, [last_mouse_x, last_mouse_y], [MOUSEMOVE, MOUSEMOVE, ...], [CARD_POS, CARD_POS, ...]]
MOUSEMOVE = [x,y,time]
CARD_POS = [x,y]
```

# Planning #

## Formato del GAME\_FILE de planning ##

### En el GAME\_FILE de un juego de planning especificamos: ###
  * nivel\_inicial (_numero natural_):
    * Es el nivel en el que se empieza jugando.
    * **tiene** que haber al menos un trial de este nivel.
  * perdidas (_numero natural_):
    * La cantidad de veces consecutivas que uno debe perder antes de disminuir el nivel.
  * victorias (_numero natural_):
    * La cantidad de veces consecutivas que uno debe ganar antes de aumentar el nivel.
  * numero\_de\_trials (_numero natural_):
    * La cantidad de trials a jugar, luego de jugar esta cantidad, el juego termina.
  * trials (_lista de TRIAL_):
    * La lista de TRIAL disponibles para el juego.
    * Cuando el juego necesita un trial de un nivel en particular, elige al azar entre todos los TRIAL que tienen ese nivel.

### TRIAL ###
  * nivel (_numero natural_):
    * El nivel de dificultad del trial.
  * max\_moves (_numero natural_)
    * La cantidad de movidas maximas permitidas para el trial, luego de esa cantidad, el trial se da por perdido. Para este fin no se considera 'movida' si el jugador comienza a arrastrar un personaje y se arrepiente soltandolo otra vez en la misma casa.

  * topleft\_house (_numero entero de 1 a 4_)
    * El id de casa que deberia estar posicionada arriba a la izquierda.
    * Los id de casa son:
      1. Casa Ana
      1. Casa Pancho
      1. Casa Nubis
      1. Lugar Vacio

  * topright\_house (_numero entero de 1 a 4_)
    * El id de casa que deberia estar posicionada arriba a la derecha.
    * ver ids de casa en topleft\_house

  * bottomleft\_house (_numero entero de 1 a 4_)
    * El id de casa que deberia estar posicionada abajo a la izquierda.
    * ver ids de casa en topleft\_house

  * bottomright\_house (_numero entero de 1 a 4_)
    * El id de casa que deberia estar posicionada abajo a la derecha.
    * ver ids de casa en topleft\_house

  * topleft\_char (_numero entero de 0 a 3_)
    * El id de personaje que deberia empezar posicionado arriba a la izquierda.
    * 0 significa que el lugar queda vacio.
    * Los id de personaje son:
      1. Ana
      1. Pancho
      1. Nubis

  * topright\_char (_numero entero de 0 a 3_)
    * El id de personaje que deberia empezar posicionado arriba a la derecha.
    * 0 significa que el lugar queda vacio.
    * ver ids de personaje en topleft\_char

  * bottomleft\_char (_numero entero de 0 a 3_)
    * El id de personaje que deberia empezar posicionado abajo a la izquierda.
    * 0 significa que el lugar queda vacio.
    * ver ids de personaje en topleft\_char

  * bottomright\_char (_numero entero de 0 a 3_)
    * El id de personaje que deberia empezar posicionado abajo a la derecha.
    * 0 significa que el lugar queda vacio.
    * ver ids de personaje en topleft\_char

### Notacion corta de un GAME\_FILE de planning ###
```
GAME_FILE = [nivel_inicial, perdidas, victorias, trial_count, [TRIAL, TRIAL, ..]]
TRIAL = [nivel, min_moves, max_moves, rotacion, topleft_house, topright_house, bottomleft_house, bottomright_house, topleft_char, topright_char, bottomleft_char, bottomright_char]
```

## Formato del LOG\_FILE de planning ##
Una vez guardado el log crudo, se puede parsear para generar un LOG\_FILE, tambien en formato de listas anidadas. En el log simplemente unimos cada TRIAL con la respuesta correspondiente (RESPONSE).

### LOG\_FILE ###
  * responses (_lista de TRIAL\_RESPONSE_)

### TRIAL\_RESPONSE ###
  * TRIAL (el TRIAL original al que se da respuesta, mismo formato del GAME\_FILE)
  * RESPONSE (una lista RESPONSE, ver mas abajo)

### RESPONSE ###
  * correct (_numero entero 1 o 0_)
    * si el trial fue terminado correctamente (o sea, lo hizo en menos de max\_moves)
  * move\_count (_numero natural_)
    * cantidad de movidas en las que resolvio el trial
  * movidas (_lista de CHAR\_DRAG_)
    * Son las movidas completadas o canceladas que se hicieron durante el trial.

### CHAR\_DRAG ###
  * char\_id (_numero entero de 1 a 3_)
    * el id del personaje siendo arrastrado
    * Los id de personaje son (como en el GAME\_FILE)
      1. Ana
      1. Pancho
      1. Nubis

  * from (_numero entero de 1 a 4_)
    * el id de casa desde donde fue arrastrado
    * Los id de casa son: (como en el GAME\_FILE)
      1. Casa Ana
      1. Casa Pancho
      1. Casa Nubis
      1. Lugar Vacio

  * to (_numero entero de 1 a 4_)
    * el id de casa hacia donde fue arrastrado
    * si es igual que _from_, entonces el movimiento fue cancelado

  * movimientos (_lista de MOUSE\_MOVE_)
    * los distintos movimientos del mouse mientras se arrastraba la ficha

### MOUSE\_MOVE ###
  * x (_numero con al menos 2 decimales_)
    * la posicion x del mouse en ese movimiento

  * y (_numero con al menos 2 decimales_)
    * la posicion y del mouse en ese movimiento

  * time (_numero natural_)
    * Los milisegundos desde el inicio del juego al momento de ese movimiento

### Notacion corta de un LOG\_FILE de planning ###
```
LOG_FILE = [TRIAL_RESPONSE, TRIAL_RESPONSE, ...]
TRIAL_RESPONSE = [TRIAL, RESPONSE]
RESPONSE = [correct, move_count, [CHAR_DRAG, CHAR_DRAG, ...]]
CHAR_DRAG = [char_id, from, to, [MOUSE_MOVE, MOUSE_MOVE, ...]]
MOUSE_MOVE = [x,y,time]
```