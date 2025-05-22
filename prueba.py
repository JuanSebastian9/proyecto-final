from random import randrange

# Función para mostrar el tablero
def mostrar_tablero(tablero):
    print("+-------" * 3, "+", sep="")  # Imprimir borde superior
    for fila in range(3):
        print("|       " * 3, "|", sep="")  # Imprimir borde de cada fila
        for col in range(3):
            print("|   " + str(tablero[fila][col]) + "   ", end="")  # Imprimir cada celda
        print("|")
        print("|       " * 3, "|", sep="")  # Imprimir borde de cada fila
        print("+-------" * 3, "+", sep="")  # Imprimir borde inferior

# Función para ingresar el movimiento del jugador
def ingresar_movimiento(tablero):
    ok = False  # Suponemos que la entrada no es válida
    while not ok:
        movimiento = input("Ingresa tu movimiento: ")  # Solicitar al jugador un movimiento
        ok = len(movimiento) == 1 and movimiento >= '1' and movimiento <= '9'  # Validar si el movimiento es correcto
        if not ok:
            print("Movimiento erróneo, ingrésalo nuevamente")  # Si no es válido, pedirlo de nuevo
            continue
        movimiento = int(movimiento) - 1  # Convertir el movimiento a índice (de 0 a 8)
        fila = movimiento // 3  # Calcular la fila
        col = movimiento % 3   # Calcular la columna
        signo = tablero[fila][col]  # Verificar qué hay en esa celda
        ok = signo not in ['O', 'X']  # Si está ocupado, no es un movimiento válido
        if not ok:  # Si la celda está ocupada, pedir un nuevo movimiento
            print("¡Cuadro ocupado, ingresa nuevamente!")
            continue
    tablero[fila][col] = 'O'  # Colocar la 'O' del jugador en el lugar seleccionado

# Función para crear una lista de celdas libres
def lista_de_campos_libres(tablero):
    libres = []  # Lista que almacena las celdas libres
    for fila in range(3):  # Iterar sobre las filas
        for col in range(3):  # Iterar sobre las columnas
            if tablero[fila][col] not in ['O', 'X']:  # Si la celda está libre
                libres.append((fila, col))  # Agregar la celda a la lista de libres
    return libres

# Función para verificar si un jugador ha ganado
def victoria_para(tablero, signo):
    if signo == "X":  # Si estamos buscando 'X'
        quien = 'me'  # 'me' significa que es la máquina
    elif signo == "O":  # Si estamos buscando 'O'
        quien = 'you'  # 'you' significa que es el jugadora
    else:
        quien = None  # Si no es 'X' ni 'O', no debería llegar aquí

    diagonal1 = diagonal2 = True  # Variables para las diagonales
    for rc in range(3):
        if tablero[rc][0] == signo and tablero[rc][1] == signo and tablero[rc][2] == signo:  # Revisar fila
            return quien
        if tablero[0][rc] == signo and tablero[1][rc] == signo and tablero[2][rc] == signo:  # Revisar columna
            return quien
        if tablero[rc][rc] != signo:  # Revisar primera diagonal
            diagonal1 = False
        if tablero[2 - rc][2 - rc] != signo:  # Revisar segunda diagonal
            diagonal2 = False
    if diagonal1 or diagonal2:  # Si alguna diagonal tiene el mismo signo, el jugador ha ganado
        return quien
    return None  # Si no ha ganado nadie, devolver None

# Función para que la computadora haga un movimiento
def movimiento_computadora(tablero):
    libres = lista_de_campos_libres(tablero)  # Obtener las celdas libres
    cnt = len(libres)
    if cnt > 0:  # Si hay celdas libres, hacer un movimiento
        este = randrange(cnt)  # Elegir aleatoriamente una celda libre
        fila, col = libres[este]
        tablero[fila][col] = 'X'  # Colocar la 'X' de la computadora en el lugar elegido

# Crear un tablero vacío
tablero = [[3 * j + i + 1 for i in range(3)] for j in range(3)]
tablero[1][1] = 'X'  # Colocar la primera 'X' en el centro
libres = lista_de_campos_libres(tablero)
turno_jugador = True  # Empezamos con el turno del jugador

# Mientras haya celdas libres, continuar el juego
while len(libres):
    mostrar_tablero(tablero)
    if turno_jugador:
        ingresar_movimiento(tablero)  # El jugador hace su movimiento
        ganador = victoria_para(tablero, 'O')  # Verificar si el jugador ha ganado
    else:
        movimiento_computadora(tablero)  # La computadora hace su movimiento
        ganador = victoria_para(tablero, 'X')  # Verificar si la computadora ha ganado
    if ganador != None:
        break  # Si hay un ganador, terminar el juego
    turno_jugador = not turno_jugador  # Cambiar de turno
    libres = lista_de_campos_libres(tablero)  # Actualizar las celdas libres

# Mostrar el tablero final y el resultado
mostrar_tablero(tablero)
if ganador == 'you':
    print("¡Has ganado!")
elif ganador == 'me':
    print("¡He ganado!")
else:
    print("¡Empate!")