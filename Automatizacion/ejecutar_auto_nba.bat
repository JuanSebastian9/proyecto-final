@echo off

REM --- Configuración ---
REM Establece la ruta a tu ejecutable de Python.
REM Opción 1: Si Python está en tu PATH, puedes usar solo "python".
SET PYTHON_EXE="C:\Users\Efrain Chapal\AppData\Local\Programs\Python\Python313\python.exe"
REM Opción 2: Si necesitas especificar la ruta completa (ejemplo, ajústala a tu instalación):
REM SET PYTHON_EXE="C:\Users\TuUsuario\AppData\Local\Programs\Python\Python39\python.exe"
REM SET PYTHON_EXE="C:\Program Files\Python39\python.exe"

REM Nombre de tu script de Python
SET PYTHON_SCRIPT="automatizacion_nba.py"

REM --- Ejecución ---
ECHO Iniciando el script de Python: %PYTHON_SCRIPT%

REM Cambia al directorio donde se encuentra este archivo .bat (y tu script .py)
cd /d "%~dp0"

REM Ejecuta el script de Python
%PYTHON_EXE% %PYTHON_SCRIPT%

ECHO.
ECHO El script de Python ha finalizado.

REM Opcional: Pausa para ver la salida antes de que la ventana se cierre.
REM Quita el "REM" de la siguiente línea si quieres que la ventana espere a que presiones una tecla.
pause