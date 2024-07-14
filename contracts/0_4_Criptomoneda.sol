// SPDX-License-Identifier: GPL-3.0

// Especifica que versión de Solidity se está utilizando.
pragma solidity >=0.8.2 <0.9.0;

// Importa la biblioteca 'console' de Hardhat para imprimir mensajes en la consola.
import "hardhat/console.sol";

// Declaración del contrato
contract CriptoGETS {
    
    // Mapping que guarda los saldos de tokens de cada usuario.
    mapping(address => uint) balances;
    mapping (address => uint) balancesBloqueados;


    // Configurar monto mínimo de transferencias
    uint montoMinimo;

    // Constructor del contrato que asigna tokens iniciales al creador.
    constructor(uint initialSupply, uint minimo) {
        // Asigna los tokens iniciales al creador del contrato.
        balances[msg.sender] += initialSupply;
        montoMinimo = minimo;
    }

    // Consultar el saldo de total de tokens de una dirección específica.
    function verBalanceTotal(address direccion) external view returns (uint) {
        return balances[direccion];
    }

    // Función para consultar el saldo disponible de tokens de una dirección específica.
    function verBalanceDisponible(address direccion) public view returns (uint) {
        return balances[direccion] - balancesBloqueados[direccion];
    }

    // Función para transferir tokens a otra dirección.
    function transferir(address destino, uint monto) external {
        // Verifica si el remitente tiene suficientes tokens para transferir.
        // Si no tiene suficientes tokens, se revierte la transacción.
        // if (balances[msg.sender] - balancesBloqueados[msg.sender] < monto) revert("No tienes fondos suficientes para esta transferencia.");
        if (verBalanceDisponible(msg.sender) < monto) revert("No tienes fondos suficientes para esta transferencia.");
        if (monto < montoMinimo) revert("El monto es menor al minimo establecido.");

        // Realiza la transferencia reduciendo el saldo del remitente.
        balances[msg.sender] -= monto;
        // Aumenta el saldo del destinatario con los tokens transferidos.
        balances[destino] += monto;
    }

    function solicitarPrestamos(uint montoPrestado) external {
        /* Verificar si el balance total disponible menos los bloqueados es mayor o igual al monto.
        De lo contrario no alcanza el saldo. */
        // if (balances[msg.sender] - balancesBloqueados[msg.sender] < montoPrestado) revert("No te alcalza el saldo para solicitar prestamo");
        if (verBalanceDisponible(msg.sender) < montoPrestado) revert("No te alcalza el saldo para solicitar prestamo");

        balancesBloqueados[msg.sender] += montoPrestado;
    }
}
