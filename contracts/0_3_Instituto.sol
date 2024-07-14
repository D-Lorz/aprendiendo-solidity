// SPDX-License-Identifier: GPL-3.0

// Indica la versión de Solidity que se va a utilizar, con restricciones de versión específicas.
pragma solidity >=0.8.2 <0.9.0;

// Importa la biblioteca 'console' de Hardhat para facilitar el registro de mensajes en la consola.
import "hardhat/console.sol";

// Declaración del contrato Instituto.
contract Instituto {
    
    // Definición de la estructura Alumno, que guarda la dirección del alumno y sus notas.
    struct Alumno {
        address direccion;
        uint8[] notas;
    }

    // Variable de estado para almacenar la dirección del administrador.
    address admin;

    // Array dinámico que guarda todas las instancias de alumnos registrados.
    Alumno[] alumnos;

    // Constructor del contrato, que asigna la dirección del creador como administrador.
    constructor() {
        admin = msg.sender;
    }

    // Función para que el administrador agregue una nota a un alumno específico.
    function agregarNota(uint8 nota, address alumno) external {
        // Requiere que el llamador de la función sea el administrador.
        if (msg.sender != admin) revert("El usuario no es el Admin");

        // Mensaje de registro si el array de alumnos está vacío.
        if (alumnos.length == 0) console.log("El array esta vacio");

        bool encontrado = false;
        uint indice;

        // Bucle para buscar al alumno en el array de alumnos.
        while (alumnos.length > 0 && !encontrado && indice < alumnos.length) {
            if (alumnos[indice].direccion == alumno) {
                encontrado = true;
                // Agrega la nota al alumno encontrado.
                alumnos[indice].notas.push(nota);
            }
            indice++;
        }

        // Si el alumno no ha sido encontrado, se crea una nueva instancia de Alumno & se agrega al array.
        if (!encontrado) {
            Alumno memory tempAlumno;
            tempAlumno.direccion = alumno;
            alumnos.push(tempAlumno);
            alumnos[alumnos.length - 1].notas.push(nota);
        }

        // Mensajes de registro de la cantidad de alumnos y la cantidad de notas del último alumno.
        console.log("# Total de Alumnos: ", alumnos.length);
        console.log("Cantidad de Notas del Alumno Actual: ", alumnos[alumnos.length - 1].notas.length);
    }

    // Función para ver el promedio de notas de un alumno específico (llamador).
    function verPromedio() external view returns (uint8) {
        bool encontrado = false;
        uint indice;
        uint suma;
        uint cantidadNotas;

        // Bucle para buscar al alumno (llamador de la función) en el array de alumnos.
        while (alumnos.length > 0 && !encontrado && indice < alumnos.length) {
            if (alumnos[indice].direccion == msg.sender) {
                encontrado = true;
                cantidadNotas = alumnos[indice].notas.length;
                // Calcula la suma de todas las notas del alumno.
                for (uint i; i < cantidadNotas; i++) {
                    suma += alumnos[indice].notas[i];
                }
            }
            indice++;
        }
        
        // Retorna el promedio de notas (suma total de notas dividida por la cantidad de notas).
        return (uint8)(suma / cantidadNotas);
    }
}
