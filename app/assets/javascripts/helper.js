function getIt($http, $location, path, callback){
	var hostname = $location.protocol() + '://' + $location.host() + ':' + $location.port();
	
	if(path.startsWith('redirect?url=')){
		var target = path.replace('redirect?url=', '');
		
		$http.get(hostname + "/referral?url=" + target).
			success(function(data, status, hdrs, config){
				if(status === 200){
					callback(true);
				}
			}).
			error(function(data, status, hdrs, config){
				console.log("Error: " + status + ' - ' + data);
				callback(false);
			});
	
	}else{
		$http.get(hostname + '/' + path).
			success(function(data, status, hdrs, config){
				callback(data);
			}).
			error(function(data, status, hdrs, config){
				callback(null);
			});
	}
}

// ----------------------------------------------------
function postIt($http, $location, path, data, callback){
	var hostname = $location.protocol() + '://' + $location.host() + ':' + $location.port();

	$http.post(hostname + '/' + path, JSON.stringify(data)).
		success(function(data, status, hdrs, config){
			callback(data);
		}).
		error(function(data, status, hdrs, config){
			console.log("Error: " + data);
			callback([]);
		});
}

// ----------------------------------------------------
function sanitize(content){
	var cleansed = content;
	
	cleansed = cleansed.replaceAll("&#8217;", "'");
	cleansed = cleansed.replaceAll("&#8217;", "'");
	
	return decodeURIComponent(escape(content));
}

// ----------------------------------------------------
function formatDate(string){
	var date = new Date();
	
	try{
		var date = new Date(string.replace(' ', 'T'));

	}catch(err){
		console.log('Invalid date: ' + string);
	}
	
	var weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'];
	var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
	
	var weekday = weekdays[date.getDay()];
	var month = months[date.getMonth()];
	var day = date.getDate().toString();
	var year = date.getFullYear().toString();
	
	//return weekday + ', ' + month + ' ' + (day[1] ? day : '0' + day) + ', ' + year;
	return month + ' ' + (day[1] ? day : '0' + day) + ', ' + year;
}

// ----------------------------------------------------
function processData(data, callback){
	if(data){
		data.forEach(function(block){
			block.forEach(function(article){
				article.publication_date = formatDate(article.publication_date);

				// De-duplicate the categories
				if(article.categories){
					article.categories = $.unique(article.categories);
				}

				// Remove the author if its the same as the publisher name or id
				if(article.author){
					if(article.author.toLowerCase() === article.publisher_id.toLowerCase()
							|| article.author.toLowerCase() === article.publisher_name.toLowerCase()){

						article.author = '';
					}
				}
			
				if(article.content){
					article.content = article.content.replace(/&nbsp;/gi, '  ');
					article.content = article.content.replace(/&#8220;/gi, '"').replace(/&#8221;/gi, '"');
				
					article.content += ' ...';
				}
			});
		});
		
		callback(data);
		
	}else{
		callback([]);
	}
}

// ----------------------------------------------------
function assignResponsiveLayout(width, article, idx){
	if(width >= 990){
		// Large desktop
		return ([0, 10].includes(idx) ? 'layout-large' : 
						([3, 12].includes(idx) ? 'layout-medium' : 
						([18, 19, 20, 21].includes(idx) ? 'double layout-text' : 
																						'layout-small')));
																						
	}else if(width > 950 && width < 990){
		// Small desktop/laptop
		return ([0, 9].includes(idx) ? 'layout-large' : 
						([4, 13].includes(idx) ? 'layout-medium' : 
						([18].includes(idx) ? 'layout-text' : 
						([19, 20, 21].includes(idx) ? 'double layout-text' : 'layout-small'))));

	}else if(width > 768 && width < 990){
		// Small laptop
		return ([0, 9].includes(idx) ? 'layout-large' : 
						([4, 13].includes(idx) ? 'layout-medium' : 
						([18, 19, 20].includes(idx) ? 'double layout-text' : 
						(idx === 21 ? 'hidden' : 'layout-small'))));

	}else if(width > 500 && width <= 768){
		// Small tablet
		return ([0, 3, 8, 11].includes(idx) ? 'layout-medium' : 
						([18, 19, 20, 21].includes(idx) ? 'double layout-text' : 
																							'layout-small'));
	}else{
		// Default to all small and doubled up text
		return ([18, 19, 20, 21].includes(idx) ? 'double layout-text' : 
																						 'layout-small');
	}
}

// ----------------------------------------------------
function sortData(data, key, ascending, callback){
/*	var out = data.sort(function(a, b){
		var x = a[key]; var y = b[key];
		if(ascending){
			return ((x < y) ? -1 : ((x > y) ? 1 : 0));
		}else{
			return ((y < x) ? -1 : ((y > x) ? 1 : 0));
		}
	});
	
	callback(out);*/
	callback(data);
}