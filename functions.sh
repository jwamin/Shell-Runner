spin() {
	local -a marks=( '/' '-' '\' '|' )
	while [[ 1 ]]; do
		printf '%s\r' "${marks[i++ % ${#marks[@]}]}"
		sleep 0.1
	done
}


#
# Directory functions
#
#

deleteDir (){
	if [ -d ./build ]; then
		echo "build dir exists... removing"
		rm -r ./build
	fi
	if [ -d ./dist ]; then
		echo "dist dir exists... removing"
		rm -r ./dist
	fi
	mkdir $dest
}

createWorkingDir(){
	mkdir -p ./working/css $dest
}

removeWorking(){
	if [ -d ./working ]; then
		rm -r ./working
	fi
}

#
# CSS functions
#
#

compileSASSandPost () {

	node-sass --quiet --source-map ./ --source-map-embed src/scss/main.scss $dest/css/package.css && postcss -c ./postcss.json -r $dest/css/package.css

}

compileVendorCss (){
	echo "compiling Vendor CSS"
	if ! [ -d $dest/css ]; then
		mkdir -p $dest/css
	fi
	touch $dest/css/vendor.css &&
	vendorCSSLength=$(cat ./package.json | node ./node_modules/json/lib/json.js vendor.length)
	vendorCSSLength=$(($vendorCSSLength - 1))
	START=0
	END=vendorCSSLength
	for (( i=$START; i<=$END; i++ ))
	do
		target=$(cat ./package.json | node ./node_modules/json/lib/json.js vendor[$i])
		echo "$(($i+1))/$(($vendorCSSLength+1))"
		echo "compiling $target"

		cat $target >> $dest/css/vendor.css
	done
	echo "done"
}

postIfy(){
	postcss -u autoprefixer -u cssnext -u postcss-opacity -o $dest/css/package.css $dest/css/package.css
}



webpackER () {

	if [ $dest = ./dist ]; then
		webpack -p --devtool inline-source-map --module-bind js=babel?presets=es2015,ignore=node_modules src/js/main.js $dest/js/bundle.js
	else
		webpack --devtool inline-source-map --module-bind js=babel?presets=es2015,ignore=node_modules src/js/main.js $dest/js/bundle.js
	fi


}

babelify () {
	mkdir $dest/js
	babel ./src/js --out-file $dest/js/package.js
}

htmlCopy() {
	cp ./src/*.html $dest &&
	cp -r ./src/assets $dest
}

uppercaseERER(){
	while read line; do
		echo $line | tr [a-z] [A-Z]
		break;
	done
}

modernize(){
	./node_modules/customizr/bin/customizr -c customizr.json
}

devModernize(){
	mkdir $dest/js/lib
	cp -r ./src/js/lib/modernizr-dev.js $dest/js/lib/modernizr-custom.js
}

watchTasks(){
	# csscmd1="node-sass src/scss/main.scss "$dest &&
	# csscmd2=$csscmd1"/css/package.css && postcss -c ./postcss.json -r "$dest &&
	# csscmd=$csscmd2"/css/package.css" &&
	# echo $csscmd &&
	#watchy --watch ./src/scss -- bash -c $csscmd &

	watchy --silent --watch ./src/scss -- bash -c  \
	"node-sass src/scss/main.scss ${dest}/css/package.css &&
	postcss -c ./postcss.json -r ${dest}/css/package.css &&
	rm -f ./package.css.map" &

	#node-sass src/scss/main.scss ./build/css/package.css && postcss -c ./postcss.json -r ./build/css/package.css &
	# watchy --watch ./src/scss -- node-sass src/scss/main.scss $dest/css/package.css &
	# watchy --watch $dest/css -- postcss -c ./postcss.json -r $dest/css/package.css &
	webpack --watch --devtool inline-source-map --module-bind js=babel?presets=es2015,ignore=node_modules src/js/main.js $dest/js/bundle.js  &
	#watch-run -p 'src/*.html' -i cp ./src/*.html $dest &
	#watch-run -p 'src/**/*.*' -i cp -r ./src/assets $dest &
	browser-sync start --server $dest --files $dest
}

message() {
	if [ $1 = 0 ];  then
		echo "Build Started"
	elif [ $1 = 1 ];  then
		echo "Watching"
	elif [ $1 = 2 ];  then
		echo "Finished"
	else
		echo "no argument"
	fi
}

cleanUp () {
	removeWorking
}

watch () {

	#do build, watch, don't compile

	# do trap , run cleanup on trap

	message 1
	devModernize
	deleteDir
	createWorkingDir
	compileSASSandPost
	compileVendorCss
	webpackER
	htmlCopy
	cleanUp
	devModernize
	watchTasks
}



build () {
	#echoCSSCmd
	#do build, don't compile
	message 0
	deleteDir
	createWorkingDir
	compileSASSandPost
	compileVendorCss
	webpackER
	htmlCopy
	cleanUp
	devModernize
	message 2
}

dist () {

	#build, compile
	message 0
	createWorkingDir
	deleteDir
	compileSASSandPost
	compileVendorCss
	webpackER
	htmlCopy
	modernize
	cleanUp
	message 2

}

echoCSSCmd () {
	echo $dest
	echo $csscmd
}
