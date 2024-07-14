// SPDX-License-Identifier: GPL-3.0

// Indica la versión de Solidity que se va a utilizar, con restricciones de versión específicas.
pragma solidity >=0.8.2 <0.9.0;

// Contrato ContestadorAutomatico que permite almacenar y consultar mensajes junto con información de fecha y usuario.
contract ContestadorAutomatico {

    string mensaje; // Variable para almacenar el mensaje actual.
    uint fecha; // Variable para almacenar la fecha en formato Unix de la última modificación del mensaje.
    address usuario; // Variable para almacenar la dirección del usuario que realizó la última modificación.

    // Constructor del contrato, inicializa el mensaje con "Hola mundo!", el usuario como el creador del contrato y la fecha actual.
    constructor() {
        mensaje = "Hola mundo!";
        usuario = msg.sender;
        fecha = block.timestamp;
    }

    // Función para actualizar el mensaje, guardando el nuevo mensaje, la dirección del usuario y la fecha actual.
    function guardarMensaje(string memory nuevoMensaje) public {
        mensaje = nuevoMensaje;
        usuario = msg.sender;
        fecha = block.timestamp;
    }

    // Función para ver el mensaje actual junto con la fecha y el usuario que lo modificó por última vez.
    function verMensaje() public view returns (string memory, uint, address) {
        return (mensaje, fecha, usuario);
    }

}
