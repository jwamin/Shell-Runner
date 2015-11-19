//Import ES6 module / class
import megaClass from "./modules/test";

//import CommonJS Module
var mod = require("./modules/module.js");

//ES2015 Constant
const LOL = "LOLOL";

//Variable
var moLOLs = "LOLOLolololololololol";

//Instantiate ES2015 Class
var myTestObj = new megaClass(moLOLs);

//Standard Console.log
console.log("hello world");

//Create and append Element
var elem = document.createElement("h1")
elem.innerHTML = mod;
document.body.appendChild(elem)

//Javascript Style redefinition
document.body.style.backgroundColor = "tomato";
document.getElementsByTagName("h2")[0].style.color = myTestObj.colourise();
