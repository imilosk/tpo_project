<?php 

require_once __DIR__ . '/../../models/Task.php';

class TaskController {

    public static function show($id) {
        $task = Task::get($id);
        Flight::json($task);
    }

    public static function store() {
        $name = $_POST["name"];
        $idProject = $_POST["idProject"];
        $response = Task::insert($name, $idProject);
        Flight::json($response);
        echo "true";
    }

    public static function delete($id) {
        $response = Task::delete($id);
        Flight::json($response);
        echo "true";
    }

    public static function update($id) {
        $id = (int) $id;
        $name = $_POST["name"];
        $response = Task::update($id, $name);
        echo "true";
    }

    public static function index() {
        $idProject = (int) Flight::request()->query['idProject'];
        $idUser = (int) Flight::request()->query['idUser'];
        if ($idUser == "") 
            $projects = Task::get_project_tasks($idProject);
        else
            $projects = Task::get_user_tasks($idUser, $idProject);
        Flight::json($projects);
    }


}