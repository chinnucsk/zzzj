var app = angular.module('zzzjApp', ['ui.bootstrap']);

app.factory('zzzjHomePageService', function ($http) {
	return {
		
		getTopEntertainmentNews: function (count, skip) {
			return $http.get('/api/news/topnews?c=Entertainment&n=' + count + '&s=' + skip).then(function (result) {
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
	
	$scope.topEntertainmentNews = zzzjHomePageService.getTopEntertainmentNews(5,0);
	$scope.topNewsWithImages = zzzjHomePageService.getTopNewsWithImages(3);
	$scope.belowFoldEntertainmentNews = zzzjHomePageService.getTopEntertainmentNews(5,5);

	
});

