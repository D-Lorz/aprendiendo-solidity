// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// Importa la biblioteca 'console' de Hardhat para facilitar el registro de mensajes en la consola.
import "hardhat/console.sol";

import "./1_Storage.sol";
import "./0_1_ContestadorAutomatico.sol";


contract LlamadaExterna {
    
    // function llamadaUsandoImport(uint valorNuevo, address direccion) external  {
    //     Storage contratoStorage = Storage(direccion);

    //     contratoStorage.store(valorNuevo);
    // }

   function storeCall(uint valorNuevo, address direccion) external {
        // Realizar la llamada usando `call` para modificar el estado del contrato externo
        (bool exito, ) = direccion.call(abi.encodeWithSignature("store(uint256)", valorNuevo));
        
        // Verificar el éxito de la llamada
        require(exito, "Fallo la llamada externa de store");

        // `resultado` puede contener algún dato de retorno de la función, pero en este caso no lo necesitamos
        console.log("Llamada exitosa a store(uint256)");
    }

    function retrieve(address direccion) external returns (uint) {
        (bool exito, bytes memory resultado) = direccion.call(abi.encodeWithSignature("retrieve()"));
        require(exito, "No funciono la llamada externa de retrieve");

        uint respuesta = abi.decode(resultado, (uint256));
        return respuesta;
    }

    // Método Import (Fácil de implementar - Se usa cuándo sé tiene el código fuente)
    // function nuevoMensaje(string memory mensaje, address direccion) external {
    //     ContestadorAutomatico contratoContestador = ContestadorAutomatico(direccion);
    //     contratoContestador.guardarMensaje(mensaje);
    // }

    /*
    * Nota.
    * address.delegatecall() tiene un sintaxis similar a call() pero se usa particularmente cuándo se usen librerías.
    * Ya que este se ejecuta dentro del contrato padre y no crea una nueva instancia.
    * Por ende es delicado implementarlo ya que si se modifican variables usando este método, se estarían modificando a nivel general del contrato en cuestión.
    */
    
    // Método Call (Se implementa usualmente cuándo no sé tiene acceso al código fuente y requiere de una firma códificada)
    function nuevoMensaje(string memory mensaje, address direccion) external {
        (bool exito, ) = direccion.call(abi.encodeWithSignature("guardarMensaje(string)", mensaje));
        // Verificar el éxito de la llamada
        require(exito, "Fallo la llamada externa de store");
    }

    function verMensaje(address direccion) external  returns (string memory) {
        (bool exito, bytes memory resultado) = direccion.call(abi.encodeWithSignature("verMensaje()"));
        require(exito, "No funciono la llamada externa de la funcion verMensaje() del Contestador Automatico");

        string memory respuesta = abi.decode(resultado, (string));
        return respuesta;
    }
}