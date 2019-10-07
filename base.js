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

