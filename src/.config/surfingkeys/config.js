map('<Ctrl-o>', '<Ctrl-i>');

unmapAllExcept([
	'<Ctrl-o>',
	':'
]);

function toggleQuote() {
	var val = document.activeElement.value;
	if (val[0] === '"') {
		document.activeElement.value = val.substr(1, val.length - 2);
	} else {
		document.activeElement.value = '"' + val + '"';
	}
}
imapkey("<Ctrl-'>", '#15Toggle quotes in an input element', toggleQuote);
cmapkey("<Ctrl-'>", '#15Toggle quotes in an input element', toggleQuote);
imapkey('<Ctrl-o>', '#15Open vim editor for current input', function() {
	var element = document.activeElement;
	Front.showEditor(element, function(data) {
		$(element).val(data);
	}, element.localName);
});

// Hints.characters = 'aoeusnthidkbpg';
//
// // tabs
//
// map('<Alt-p>', 'E');
// map('<Alt-n>', 'R');
// imap('<Alt-p>', 'E');
// imap('<Alt-n>', 'R');
// unmap('E');
// unmap('R');
//
// map('<Alt-c>', 'x');
// unmap('x');
//
// map('<Alt-Tab>', 'B');
// map('<Alt-Shift-Tab>', 'F');
//
// map('gm', '<Alt-m>');
//
// // scrolling
//
// map('<Ctrl-b>', 'e');
// map('<Ctrl-u>', 'e');
// map('<Ctrl-f>', 'd');
// map('<Ctrl-d>', 'd');
// unmap('e');
// unmap('d');
//
// map('gp', '<Alt-p>');
//
// map('gD', 'yt');
// unmap('yt');
//
// // history
//
// map('J', 'H');
//
// map('H', 'S');
// map('L', 'D');
//
// // INSERT
//
// iunmap('<Ctrl-f>');
//
// map('<Ctrl-o>', '<Ctrl-i>');
// imap('<Ctrl-o>', '<Ctrl-i>');
// unmap('<Ctrl-i>');
// iunmap('<Ctrl-i>');
