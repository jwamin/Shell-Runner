'use strict';

class testClass {
	constructor(message) {
		this.message = message
	}

	colourise() {

			return '#' + (Math.random() * 0xFFFFFF << 0).toString(16);

	}

}

export default testClass;