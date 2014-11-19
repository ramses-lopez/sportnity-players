ready = ->
	$('[type=text], textarea, select').addClass('form-control')
	$('submit, input[type=submit], input[type=button]').addClass('btn')

$(document).ready(ready)