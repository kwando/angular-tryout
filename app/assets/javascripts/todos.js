TodoCtrl = ['$scope', function($scope){
  $scope.todos = [
    {text: 'learn angular', done: true},
    {text: 'build an angular app', done: false}
  ];

  $scope.remaining = function(){
    var count = 0;
    angular.forEach($scope.todos, function(todo){
      if(todo.done){
        count++;
      }
    });
    return count;
  };

  $scope.archive = function(){
    var oldTodos = $scope.todos;
    $scope.todos = [];
    angular.forEach(oldTodos, function(todo){
      if(!todo.done){
        $scope.todos.push(todo);
      }
    });
  }

  $scope.validInput = function(){
    return $scope.todoText.toString().length > 0;
  }

  $scope.addTodo = function(){
    if($scope.validInput()){
      $scope.todos.push({
        text: $scope.todoText,
        done: false
      });
      $scope.todoText = '';
    }
  }
}];