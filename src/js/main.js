//Import ES6 module / class
import * as moduleImport from "./modules/test";

import myClass from "./modules/module";

//import CommonJS Module
//var mod = require("./modules/module.js");

//ES2015 Constant
const LOL = "LOLOL";

//Variable
var moLOLs = "LOLOLolololololololol";

//Instantiate ES2015 Class
var myTestObj = new moduleImport.testClass(moLOLs);

moduleImport.countUp(9989);

console.log(moduleImport)

//Standard Console.log
console.log("hello world");
console.log(LOL);

//Create and append Element


//Javascript Style redefinition
document.body.style.backgroundColor = "tomato";
document.getElementsByTagName("h2")[0].style.color = myTestObj.colourise();


//Private method test

var myObj = new myClass("Hello (private) world");
myObj.readPrivate();

var elem = document.createElement("h1");
elem.innerHTML = myObj.readPrivate();
document.body.appendChild(elem)