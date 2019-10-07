/* JS Library */

function _e(elem){
	if(typeof(elem)=='object') return elem;
	else return document.getElementById(elem);
};

function show(e,display){
	if(typeof(display)==='undefined') display='';
	if((e=_e(e))) {
		if(display!==false) e.style.display=display;
		e.style.visibility='visible';
		return true;
	}
	return false;
};

function hide(e,display){
	if(typeof(display)==='undefined') display='none';
	if((e=_e(e))) {
		if(display!==false) e.style.display=display;
		e.style.visibility='hidden';
		return true;
	}
	return false;
};


function enable(e){
	if((e=_e(e))) {
		e.removeAttribute('disabled');
		return true;
	}
	return false;
};

function disable(e){
	if((e=_e(e))) {
		e.setAttribute('disabled','true');
		return true;
	}
	return false;
};



function resetForm(el) {
    // variable declaration
    var x, y, z, type = null, object = [];
    // collect form elements
    object[0] = document.getElementById(el).getElementsByTagName('input');
    object[1] = document.getElementById(el).getElementsByTagName('textarea');
    object[2] = document.getElementById(el).getElementsByTagName('select');
    // loop through found form elements
    for (x = 0; x < object.length; x++) {
        for (y = 0; y < object[x].length; y++) {
            // define element type
            type = object[x][y].type;
            switch (type) {
            case 'text':
            case 'textarea':
            case 'password':
                object[x][y].value = '';
                break;
            case 'radio':
            case 'checkbox':
                object[x][y].checked = '';
                break;
            case 'select-one':
                object[x][y].options[0].selected = true;
                break;
            case 'select-multiple':
                for (z = 0; z < object[x][y].options.length; z++) {
                    object[x][y].options[z].selected = false;
                }
                break;
            } // end switch
        } // end for y
    } // end for x
};


