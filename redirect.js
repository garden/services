require('http').createServer(function(req,res){
	res.writeHead(301, {
		'Location': 'https://thefiletree.com' + req.url
	})
	res.end();
}).listen(80);
