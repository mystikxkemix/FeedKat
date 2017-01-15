<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// API : get all cats
$app->get('/collar', function() use ($app) {
    $data = $app['db']->fetchAll('select * from collar');
	return $app->json($data);
});

$app->put('/collar', function (Request $request) use ($app) {

	$data_cat = array('id_cat','mac');
	
	$ins_col = array();
	foreach($data_cat as $col)
		if($request->request->get($col) != '')	
			$ins_col[$col] = '\''.$request->request->get($col).'\'';
	
	$ins_sql = "insert into collar ";
	$ins_sql .= '('.implode(',',array_keys($ins_col)).')';
	$ins_sql .= " values (";
	$ins_sql .= implode(', ',$ins_col).')';
	
	$r = $app['db']->query($ins_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
	$post['error'] = $error;
	$post['id_collar'] = $app['db']->lastInsertId();
	
    return $app->json($post);
});


// API : get a specific collar
$app->get('/collar/{id}', function($id) use ($app) {
    $data = $app['db']->fetchAll('select * from collar where id_collar = \''.$id.'\'');
	return $app->json($data);
});

// API : get cats by cat ID
$app->get('/collar/cat/{id}', function($id) use ($app) {
	$res = $app['db']->fetchAll('select id_cat from cat c where id_cat = \''.$id.'\'');
	if(count($res) == 0)
	{
		$data['error'] = 1;
	}
	else
	{	
		$cats = $app['db']->fetchAll('select c.*, cl.* from cat c join collar cl using(id_cat) where c.id_cat = \''.$id.'\'');
		
		$data['error'] = 0;
		$data['cats'] = $cats;
	}
	
	return $app->json($data);
});

// API : get cats by dispenser ID
$app->get('/cat/dispenser/{id}', function($id) use ($app) {
    $cats = $app['db']->fetchAll('select c.* from cat c join cat_dispenser cd using(id_cat) join dispenser d using(id_dispenser) join user u using(id_user) where d.id_dispenser = \''.$id.'\'');
	return $app->json($cats);
})->bind('api_cats_by_dispenser');


// API : delete a cat
$app->delete('/cat/{id}', function(Request $request) use ($app) {
	$id = $request->request->get('id_cat');
	return $app->json(deleteId('id_cat',$id,'cat'), 201);
})->bind('api_cat_delete');

/*
$app->put('/feedtimes', function (Request $request) use ($app) {
	$data_feedtime = array('id_cat','id_dispenser','time','weight','enabled');
	*/
	

// API : get free collars by user id
$app->get('/freecollars/user/{id}', function($id) use ($app) {
    $cats = $app['db']->fetchAll('select id_collar, id_cat from collar where id_cat is null and id_user = '.$id.'');
	foreach($cats as $k=>$v) {
		$cats[$k]['id_collar'] = (int) $cats[$k]['id_collar'];
		$cats[$k]['id_cat'] = (int) $cats[$k]['id_cat'];
	}
	return $app->json($cats);
});


?>