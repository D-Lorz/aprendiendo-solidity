// SPDX-License-Identifier: GPL-3.0

// Indica la versión de Solidity que se va a utilizar, con restricciones de versión específicas.
pragma solidity >=0.8.2 <0.9.0;

// Declaración del contrato Subasta
contract Subasta {
    
    // Dirección del mayor postor actual y la cantidad máxima apostada.
    address public mayorPostor;
    uint public maximaApuesta;

    // Variable para almacenar la fecha de finalización de la subasta.
    uint fechaFinSubasta;

    // Constructor del contrato que establece la fecha de finalización de la subasta en 5 minutos desde el despliegue.
    constructor() {
        fechaFinSubasta = block.timestamp + 5 minutes;
    }

    // Función para realizar una apuesta en la subasta.
    function apostar(uint apuestaNueva) public {
        // Verifica si la subasta ha finalizado.
        if (block.timestamp >= fechaFinSubasta) {
            revert("La subasta ya ha finalizado");
        }

        // Verifica si la nueva apuesta es mayor que la máxima apuesta actual.
        if (apuestaNueva <= maximaApuesta) revert("La nueva apuesta debe ser mayor que la apuesta maxima actual");

        // Actualiza al nuevo mayor postor y la nueva máxima apuesta.
        mayorPostor = msg.sender;
        maximaApuesta = apuestaNueva;
    }
}
