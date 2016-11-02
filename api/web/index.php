<?php
header('Access-Control-Allow-Origin: *');
require_once __DIR__.'/../vendor/autoload.php';

$app = new Silex\Application();

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;


function deleteId($idCol, $idVal, $table) {
	global $app;
	
	$r = $app['db']->query('delete from '.$table.' where '.$idCol.' = \''.$idVal.'\'');
	
	
	$error = ($r !== false) ? 0 : 1;
    $post = array(
        'error' => $error,
        $idCol  => $idVal
    );
    $json = $app['db']->query('select * from '.$table.' where '.$idCol.' = \''.$idVal.'\'');

	return $json;
}


$app->before(function (Request $request) {
    if (0 === strpos($request->headers->get('Content-Type'), 'application/json')) {
        $data = json_decode($request->getContent(), true);
        $request->request->replace(is_array($data) ? $data : array());
    }
});

require_once('sql.inc.php');

//configure database connection
$app->register(new Silex\Provider\DoctrineServiceProvider(), 
	$db_options
);


$app->get('/', function () {
    return 'TEST - Hello world';
});


/*
FEED TIMES MANAGEMENT
*/
require_once('feedtimes.php');

/*
USER
*/
require_once('user.php');

/*
CAT MANAGEMENT
*/
require_once('cats.php');

/*
CAT COLLAR MANAGEMENT
*/
require_once('catcollar.php');





$app->run();