var app = angular.module('zzzjApp', ['ui.bootstrap']);

app.factory('zzzjHomePageService', function ($http) {
	return {
		
		getTopEntertainmentNews: function (count) {
			return $http.get('/api/news/topnews?c=Entertainment&n=' + count).then(function (result) {
				return result.data.rows;
			});
		},
		getTopNewsWithImages: function (count) {
			return $http.get('/api/news/topnews_with_images?n=' + count).then(function (result) {
				return result.data.rows;
			});
		},


	};
});
app.controller('ZzzjHome', function ($scope, zzzjHomePageService) {
	//the clean and simple way
	
	$scope.topEntertainmentNews = zzzjHomePageService.getTopEntertainmentNews(5);
	$scope.topNewsWithImages = zzzjHomePageService.getTopNewsWithImages(3);

	
});

