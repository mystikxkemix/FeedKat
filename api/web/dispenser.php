<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// API : get dispensers by user ID
$app->get('/dispenser/user/{id}', function($id) use ($app) {
    $data = $app['db']->fetchAll('select id_dispenser, name, stock from dispenser where id_user = \''.$id.'\'');
	if(count($data) == 0)
		$data = array('error' => 1);
	else {
		$data = array('error' => 0, 'dispensers' => $data);
	}
	return $app->json($data);
});

// API : add a new dispenser
$app->put('/dispenser', function (Request $request) use ($app) {

	$cols = array('name','id_user', 'stock');
	
	$ins_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '')	
			$ins_col[$col] = '\''.$request->request->get($col).'\'';
	
	$ins_sql = "insert into dispenser ";
	$ins_sql .= '('.implode(',',array_keys($ins_col)).')';
	$ins_sql .= " values (";
	$ins_sql .= implode(', ',$ins_col).')';
	
	$r = $app['db']->query($ins_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
	$post['error'] = $error;
	$post['id_dispenser'] = $app['db']->lastInsertId();
	
    return $app->json($post);
});

// API : update a dispenser
$app->post('/dispenser', function (Request $request) use ($app) {
	$id = $request->request->get('id_dispenser');
	
	$cols = array('name', 'id_user', 'stock');
	
	$upd_col = array();
	foreach($cols as $col)
		if($request->request->get($col) != '')
			$upd_col[] = $col.' = \''.$request->request->get($col).'\'';
	
	$upd_sql = "update dispenser set ";
	$upd_sql .= implode(', ',$upd_col);
	$upd_sql .= " where id_dispenser = $id";
	
	$r = $app['db']->query($upd_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
    $post = array(
        'error' => $error,
        'id_dispenser'  => $request->request->get('id_dispenser')
    );
	
	return $app->json($post);
});


?>