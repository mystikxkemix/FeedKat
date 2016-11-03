<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// API : get dispensers by user ID
$app->get('/dispenser/user/{id}', function($id) use ($app) {
    $data = $app['db']->fetchAll('select * from dispenser where id_user = \''.$id.'\'');
	return $app->json($data);
});

?>