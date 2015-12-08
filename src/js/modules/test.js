'use strict';

class testClass {
	constructor(message) {
		this.message = message
	}

	colourise() {

			return '#' + (Math.random() * 0xFFFFFF << 0).toString(16);

	}

}

function countUp(limit){
	var i = 0;
	while(i<limit){
		console.log(i+1);
		i++;
	}
}

export {testClass, countUp};