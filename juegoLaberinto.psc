/// [IMPORTANTE]: AL EJECUTAR EL JUEGO AGRANDAR UN POCO LA PANTALLA DE EJECUCIÓN PARA PODER VER EL LABERINTO COMPLETAMENTE.(tambien depende del tamaño del mismo).

/// "Salida de un laberinto": Se trata de encontrar un camino que nos permita salir de un laberinto definido en una matriz NxN. 
///	- Para movernos por el laberinto, sólo podemos pasar de una casilla a otra que sea adyacente a la primera
///  y no esté marcada como una casilla prohibida (esto es, las casillas prohibidas determinan las paredes que forman el laberinto).
	
///	Algoritmo recursivo:		
///		- Se comienza en la casilla (0,0) y se termina en la casilla (N-1, N-1)
///		- Nos movemos a una celda adyacente si esto es posible.
///		- Cuando llegamos a una situación en la que no podemos realizar ningún movimiento que nos lleve a una celda que no hayamos visitado ya,
///		  retrocedemos sobre nuestros pasos y buscamos un camino alternativo.

Algoritmo juegoLaberinto
	
	Definir laberinto, fichaJugador, direccionMovimiento Como Caracter;  // variables-> laberinto: es la matriz principal donde se muestra graficamente el juego. ficha jugador: la usamos para identificar posicion jugador en la matriz(linea_18). direccionMovimiento: es una letra que tomamos de referencia para hacer el movimiento del jugador.
	Definir tamanioLaberinto Como Entero;  // para dimensionar nuestro laberinto(matriz).
	
	fichaJugador = '&';  // visualmente nuestro jugador es representado en la matriz con &.
	direccionMovimiento = 'X'; // inicializamos la variable direccionMovimiento, para que ingrese en la estructura Mientras(Linea 29), y no nos dé error de inicializar.
	
	Escribir "** Bienvenidos al laberinto **";
	Escribir "[IMPORTANTE]: AGRANDAR LA PANTALLA DE EJECUCIÓN PARA PODER VER EL LABERINTO COMPLETAMENTE.(tambien depende del tamaño del mismo).";
	Escribir "Ingrese tamaño del laberinto:";
	Leer tamanioLaberinto;  // pedimos el tamaño que deseamos para nuestro laberinto, a ese dato lo guardamos en la variable tamanioLaberinto.
	
	Dimension laberinto[tamanioLaberinto,tamanioLaberinto];  // dimensionamos la matriz laberinto con el "tamaño" ingresado por el usuario.
	definirParedesEnLaberinto(laberinto, tamanioLaberinto, fichaJugador);  // llamamos a la funcion definirParedesEnLaberinto (Linea 37-57). y le pasamos como argumentos los datos que nos pide esa funcion (entre parentesis).
	
	Mientras direccionMovimiento <> 'Q' Hacer  // usamos un Mientras para repetir el llamado de las funciones (para que nuestro programa siga corriendo indefinidamente...), hasta que la variable direccionMovimiento sea = Q. 
		mostrarMatriz(laberinto,tamanioLaberinto);  // llamamos a la funcion mostrarMatriz (Linea 78-97).
		menuJugador(laberinto, tamanioLaberinto, fichaJugador, direccionMovimiento);  // llamamos a la funcion menuJugador (Linea 99-109).
		moverJugador(laberinto, tamanioLaberinto, fichaJugador, direccionMovimiento);  // llamamos a la funcion moverJugador (Linea 111-193).
	FinMientras
	
FinAlgoritmo
///------------------------------------------------------------------------------------------------------------------------------------------------
Funcion definirParedesEnLaberinto(laberinto, tamanioLaberinto, fichaJugador)  // la funcion se identifica con el nombre definirParedesEnLaberinto, y define ciertos parámetros(entre parentesis), que necesita como input dato de entrada para trabajar esos datos.
	Definir i, j Como Entero;  // usamos la variable i: para recorrer las filas de nuestra matriz, y la variable j: para recorrer las columnas de nuestra matriz.
	
	Para i=0 Hasta tamanioLaberinto-1 Con Paso 1 Hacer  // recorremos las filas(i) de la matriz hasta tamanioLaberinto-1, porque sino se sale de rango. Al dimensionar un arreglo ó matriz, por ejemplo de tamaño 5, su indice va de 0-4 (son 5 posiciones),entonces si queremos acceder a la posicion 5, no existe, porque vemos que solo llega hasta 4, por eso tamaño -1.
		Para j=0 Hasta tamanioLaberinto-1 Con Paso 1 Hacer  // misma logica que con las filas, recorremos las columnas(j).
			
			Si (i=0) O (i=tamanioLaberinto-1) Entonces   // estamos diciendo que, si el indice i esta en la 1ra fila(0) Ó en la ultima(tamanioLaberinto-1), si alguna de estas condiciones es verdadera, entonces, significa que son los bordes de arriba y abajo de nuestro laberinto.
				laberinto[i,j] = "*";  // al mismo tiempo en la posicion del recorrido(i,j) donde se encuentra nuestra matriz(laberinto), le guardamos el valor '*'(para representar las "paredes").                
			SiNo
				Si (j=0) O (j=tamanioLaberinto-1) Entonces   // estamos diciendo que, si el indice j esta en la 1ra columna(0) ó en la ultima(tamanioLaberinto-1), si alguna de estas condiciones es verdadera, entonces, significa que son los bordes de la izquiera y derecha de nuestro laberinto.
					laberinto[i,j] = "*";  // mismo que Linea 44.
				SiNo
					laberinto[i,j] = " ";   // en cualquier otro caso, llenamos la matriz con ' '(espacio vacio).
				FinSi				
			FinSi
			laberinto[1,1] = fichaJugador; // posicionamos nuestra ficha de jugador en nuestro laberinto(Linea 18).
			laberinto[tamanioLaberinto-2,tamanioLaberinto-1] = ' '; // dejamos libre la salida del laberinto, con un espacio en blanco. (se usa misma logica de rangos que en linea 40).
		FinPara		
	FinPara
	agregarObstaculos(laberinto, tamanioLaberinto, fichaJugador);  // invocamos la funcion agregarObstaculos. Linea 59-76.
FinFuncion
///------------------------------------------------------------------------------------------------------------------------------------------------
Funcion agregarObstaculos(laberinto Por Referencia, tamanioLaberinto, fichaJugador)  // laberinto Por Referencia, indicamos que vamos a hace referencia en memoria, es decir, las modificacion se va guardar en la matriz(laberinto original).
	Definir i,j, x, cantidadObstaculos Como Entero;  // variables x: la usamos para guardar el valor de un numero aleatorio.
	Definir obstaculo Como Caracter;
	
	obstaculo = '@';  // visualmente nuestro obstáculo es representado en la matriz con @.	
	cantidadObstaculos = trunc((tamanioLaberinto-1)/2);  // en cantidadObstaculos, vamos a guardar el valor de dividir el tamanioLaberinto entre 2, y a ese resultado, se le trunc(se le quita la parte decimal.)
	
	Para i=0 Hasta tamanioLaberinto-1 Con Paso 1 Hacer  // recorremos solo las filas con i.
		
		x = Aleatorio(1,tamanioLaberinto-1);  // le damos un valor aleatorio a x.
		
		Si (laberinto[i,x] = ' ') Y (cantidadObstaculos > 0) Entonces  //aca estamos evaluando, si laberinto[i,x](donde x, es la posicion de la columna) = ' ', es decir, esta libre esa casilla Y cantidadObstaculos > 0.(Ver Linea 64).
			laberinto[i,x] = obstaculo; // entonces en esa misma posicion donde estoy posicionado en mi iteracion, le guardamos el valor de obstaculo.(Linea 63).
			cantidadObstaculos = cantidadObstaculos -1;	 // le estamos restando 1, al valor de la variable cantidadObstaculos, hasta que llegue a 0, y no se cumpla mas la condicion.
		FinSi		
		
	FinPara	
FinFuncion
///------------------------------------------------------------------------------------------------------------------------------------------------
Funcion mostrarMatriz(laberinto,tamanioLaberinto)
	Definir i,j Como Entero;
	Limpiar Pantalla;
	
	Para i=0 Hasta tamanioLaberinto-1 Con Paso 1 Hacer
		Para j=0 Hasta tamanioLaberinto-1 Con Paso 1 Hacer
			
			Escribir Sin Saltar "[", laberinto[i,j], "]";  // recorremos y mostramos nuestra matriz(laberinto) por pantalla, con Sin Saltar, lo que logramos es, imprimir un elemento, seguido(al lado) de otro, y con "[" "]", creamos el efecto de "casilla".
			
		FinPara
		Escribir "";  // usamos esta Linea para pasar a la "fila de abajo", es decir, con el Para de indice j recorremos las columnas, cuando termina de recorrer las columnas y antes de cambiar de fila(i), se lee esta linea, y al imprimir(""), sigue en la linea de abajo.
	FinPara
	
	Escribir "";	// se usa para separar un poco las instrucciones. 
	Escribir " ~ Su ficha de jugador es: [&]";
	Escribir " ~ Las paredes son: [*]";
	Escribir " ~ Los Obstáculos son: [@]";
	Escribir " ~ Lugar vácio: [ ]";
	Escribir "";
FinFuncion
///------------------------------------------------------------------------------------------------------------------------------------------------
Funcion menuJugador(laberinto, tamanioLaberinto, fichaJugador, direccionMovimiento Por Referencia)		
	Escribir "A continuación, ingrese una letra:       (Sólo se permite W, S, A, D)";  // mostramos el menu al usuario, para indicarle como utilizar el programa.
	Escribir "W -> Para mover el jugador hacia [arriba].";
	Escribir "S -> Para mover el jugador hacia [abajo].";
	Escribir "A -> Para mover el jugador hacia [izquierda].";
	Escribir "D -> Para mover el jugador hacia [derecha].";
	Escribir "Q -> Para SALIR.";
	Escribir "Ingrese su movimiento y Presione [ENTER] para continuar: ";
	Leer direccionMovimiento;  // al valor que nos ingresa el usuario lo guardamos en la variable direccionMovimiento.
	direccionMovimiento = Mayusculas(direccionMovimiento);  // si nos ingresan un caracter en minusculas, con la funcion Mayusculas(), lo convertimos Mayusculas. 
FinFuncion
///------------------------------------------------------------------------------------------------------------------------------------------------
Funcion moverJugador(laberinto Por Referencia, tamanioLaberinto, fichaJugador, direccionMovimiento)	
	Definir i, j Como Entero;
	Definir caminar Como Logico;  // usamos una variable de tipo logico, como bandera, para indicarnos si efectua un moviento o no.(se usa como condicion para ingresar en las siguientes estructuras y llevar el "control" de las mismas).
	caminar = Falso;  // inicia en valor Falso, significa que, no se ha producido un movimiento aún.
	
	Para i=0 Hasta tamanioLaberinto-1 Con Paso 1 Hacer
		Para j=0 Hasta tamanioLaberinto-1 Con Paso 1 Hacer
			
			Si laberinto[i,j] = fichaJugador Entonces  // recorremos nuestro laberinto, hasta que, laberinto[i,j] sea igual(=) al valor de fichaJugador(si ese elemento en el cual estamos posicionados es igual al valor de fichaJugador) Entonces ->
				
				Segun direccionMovimiento Hacer  // evaluamos la variable direccionMovimiento (Linea 107). en nuestro programa principal, como la funcion menuJugador se "invoco" antes(linea 31), que la funcion moverJugador(linea 32), la variable direccionMovimiento ya tiene valor.
					'W':  // si vale W ingresa aca ->					
						Si (laberinto[i-1,j] = ' ') Y (caminar = Falso) Entonces  // para entender la 1ra condicion, ver Linea 196-204. si ese elemento de la matriz(laberinto) = ' ', significa que esta vacio, y si se puede realizar el movimiento, Entonces ->
							laberinto[i,j] = ' ';  // en la posicion del recorrido(i,j) donde se encuentra nuestra matriz(laberinto) guardamos el valor ' ', para simular que esta vacia esa posicion. Recordemos que hasta este momento en la posicion laberinto[i,j] = fichaJugador.(Ver Linea 119).
							laberinto[i-1,j] = fichaJugador;  // mismos indices que la 1ra condicion, estamos guardando el valor de la fichaJugador, en la "nueva" posicion en el laberinto. 
							caminar = Verdadero;  // finalmente a la variable caminar le cambiamos su valor a Verdadero, ya que, sí se realizo el movimiento.
						FinSi
						
						Si (laberinto[i-1,j] = '*') O (laberinto[i-1,j] = '@') Entonces  // si la posicion de la matriz es = '*' O '@', sabemos que es una pared/obstaculo, ya que son los simbolos que los representan.
							Escribir "Has chocado contra una pared u obstáculo.";
							Esperar 2 Segundos;
							caminar = Verdadero;								
						FinSi							
						
					'S':  // si vale S ingresa aca ->	
						Si (laberinto[i+1,j] = ' ') Y (caminar = Falso) Entonces
							laberinto[i,j] = ' ';
							laberinto[i+1,j] = fichaJugador;
							caminar = Verdadero;
						FinSi
						Si caminar = Falso Entonces
							Si (laberinto[i+1,j] = '*') O (laberinto[i+1,j] = '@') Entonces
								Escribir "Has chocado contra una pared u obstáculo.";
								Esperar 2 Segundos;
								caminar = Verdadero;								
							FinSi	
						FinSi
					'A':  // si vale A ingresa aca ->	
						Si (laberinto[i,j-1] = ' ') Y (caminar = Falso) Entonces
							laberinto[i,j] = ' ';
							laberinto[i,j-1] = fichaJugador;
							caminar = Verdadero;
						FinSi
						
						Si (laberinto[i,j-1] = '*') O (laberinto[i,j-1] = '@') Entonces
							Escribir "Has chocado contra una pared u obstáculo.";
							Esperar 2 Segundos;
							caminar = Verdadero;								
						FinSi	
						
					'D':  // si vale D ingresa aca ->	
						Si (laberinto[i,j] = laberinto[tamanioLaberinto-2,tamanioLaberinto-1]) Entonces  // si la posicion de la matriz es = laberinto[tamanioLaberinto-2,tamanioLaberinto-1] sabemos que es nuestra salida del laberinto(ver Linea 53).
							Escribir "Fecilitaciones, has encontrado la salida.";
							laberinto[i,j] = fichaJugador;  // posicionamos nuestro jugador en la salida.
							Escribir "Presione una tecla para continuar...";
							Esperar Tecla;
							caminar = Verdadero;
						Sino						
							Si (laberinto[i,j+1] = ' ') Y (caminar = Falso) Entonces
								laberinto[i,j] = ' ';
								laberinto[i,j+1] = fichaJugador;
								caminar = Verdadero;
							FinSi
							Si caminar = Falso Entonces
								Si (laberinto[i,j+1] = '*') O (laberinto[i,j+1] = '@') Entonces									
									Escribir "Has chocado contra una pared u obstáculo.";
									Esperar 2 Segundos;
									caminar = Verdadero;								
								FinSi	
							FinSi
						FinSi						
						
					'Q':  // con la letra Q finalizamos la ejecucion.
						Escribir "** Laberinto Ejecución Finalizada. **";
					De Otro Modo:  // si no es ninguna de las opciones evaluadas, ingresa aca ->
						Escribir "Opción Incorrecta.";
						mostrarMatriz(laberinto,tamanioLaberinto);
						menuJugador(laberinto, tamanioLaberinto, fichaJugador, direccionMovimiento);
				FinSegun
			FinSi			
		FinPara		
	FinPara	
FinFuncion
///------------------------------------------------------------------------------------------------------------------------------------------------

/// Ejemplo de matriz 6x6 (0-5 son 6 elementos):

///  	    j=0   j=1   j=2   j=3   j=4   j=5
///  i=0   [0,0] [0,1] [0,2] [0,3] [0,4] [0,5]		- Si queremos ir para "arriba", tenemos que restar al indice i, el valor de 1.(i-1)
///  i=1   [1,0] [1,1] [1,2] [1,3] [1,4] [1,5]		- Si queremos ir para "abajo", tenemos que sumarle al indice i, el valor de 1.(i+1)
///  i=2   [2,0] [2,1] [2,2] [2,3] [2,4] [2,5]		- Si queremos ir para "izquierda", tenemos que restar al indice j, el valor de 1.(j-1)
///  i=3   [3,0] [3,1] [3,2] [3,3] [3,4] [3,5]		- Si queremos ir para "derecha", tenemos que sumarle al indice j, el valor de 1.(j+1)
///  i=4   [4,0] [4,1] [4,2] [4,3] [4,4] [4,5]
///  i=5   [5,0] [5,1] [5,2] [5,3] [5,4] [5,5]

/// ~ Matias Nicolas Acevedo ~ 
