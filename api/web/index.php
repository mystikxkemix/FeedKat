<?php

require_once __DIR__.'/../vendor/autoload.php';

$app = new Silex\Application();

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;


function deleteId($idCol, $idVal, $table) {
	/*
	$r = $app['db']->query('delete from '.$table.' where '.$idCol.' = \''.$idVal.'\'');
	
	$error = ($r !== false) ? 0 : 1;
    $post = array(
        'error' => $error,
        $idCol  => $idVal
    );
    $json = $app['db']->query('select * from '.$table.' where '.$idCol.' = \''.$idVal.'\'');
	*/
	$json = array('test');
	return $json;
}

$app->before(function (Request $request) {
    if (0 === strpos($request->headers->get('Content-Type'), 'application/json')) {
        $data = json_decode($request->getContent(), true);
        $request->request->replace(is_array($data) ? $data : array());
    }
});


//configure database connection
$app->register(new Silex\Provider\DoctrineServiceProvider(), array(
    'db.options' => array(
        'driver' => 'pdo_mysql',
        'host' => '127.0.0.1',
        'dbname' => 'feedkat',
        'user' => 'root',
        'password' => '',
        'charset' => 'utf8',
    ),
));


$app->get('/', function () {
    return 'Hello world';
});

$app->get('/hello/{name}', function ($name) use ($app) {
    return 'Hello ' . $app->escape($name);
});	


/*
CAT MANAGEMENT
*/
require_once('cats.php');

/*
FEED TIMES MANAGEMENT
*/
require_once('feedtimes.php');

/*
CAT COLLAR MANAGEMENT
*/
require_once('catcollar.php');





$app->run();