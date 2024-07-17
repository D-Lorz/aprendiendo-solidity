// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/* Los contratos abstractos se usan como base o molde para poder reutilizar sus funciones en otros.
* Asímismo pueden tener funciones que no están completamente escritas o tiene parte de estas definidas.
* No son para desplegar.
*/
abstract contract Persona {
    
    string nombre;

    constructor (string memory _nombre) {
        nombre = _nombre;
    }

    function verDatos() public view virtual returns (string memory) {
        return nombre;
    }

    // function verProfesion() external view virtual returns(string memory);
}

/* Las interfaces son contratos bases para estructurar funciones o definir un lineamiento.
* Tiene sentido para cuándo no sé necesito hacer un deploy del contrato.
*/
interface isPersona {
    function verProfesion() external view returns (string memory);
    function verDatos() external view returns (string memory);
    
}

contract Abogado is Persona {
    constructor(string memory _nombre) Persona(_nombre) {}

    function verDatos() public view override returns (string memory) {
        string memory datosOriginales = super.verDatos();
        return (string)(abi.encodePacked(datosOriginales, " y soy Abogado"));
    }
}