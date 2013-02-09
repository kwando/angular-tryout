ForumController = ['$scope','$http', function($scope, $http){
  $scope.topics = [];
  $scope.status = 'idle';

  $scope.update = function(){
    if($scope.status == 'fetching'){
      return;
    }
    $scope.status = 'fetching';
    $http.get('/jme_forum.json').success(function(json){
      $scope.topics = json;
      $scope.status = 'idle';
    });
  }

  setInterval(function(){
    console.log('updating');
    $scope.$apply(function(){
      $scope.update();
    });
  }, 60*1000);
}];