"use strict";

const _private = new WeakMap();

class myClass{
	constructor(value){
	_private.set(this,value);
	}
	readPrivate(){
		return _private.get(this);
	}
}

export default myClass;