<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\HttpFoundation\Response;

// API : get all cats
$app->get('/cat', function() use ($app) {
    $cats = $app['db']->fetchAll('select c.*, group_concat(d.id_dispenser) id_dispenser, u.id_user from cat c left join cat_dispenser cd using(id_cat) left join dispenser d using(id_dispenser) join user u using(id_user) ');
	$cats[0]['id_dispenser'] = explode(',', $cats[0]['id_dispenser']);
	return $app->json($cats);
})->bind('api_cats');

$app->put('/cat', function (Request $request) use ($app) {

	$data_cat = array('name','birth','photo');
	
	$ins_col = array();
	foreach($data_cat as $col)
		if($request->request->get($col) != '')	
			$ins_col[$col] = '\''.$request->request->get($col).'\'';
	
	$ins_sql = "insert into cat ";
	$ins_sql .= '('.implode(',',array_keys($ins_col)).')';
	$ins_sql .= " values (";
	$ins_sql .= implode(', ',$ins_col).')';
	
	$r = $app['db']->query($ins_sql);
	
	if($r !== false)
		$error = 0;
	else
		$error = 1;
	
    //$post = array(
    //    'error' => $error,
    //    'id_cat'  => $app['db']->lastInsertId()
    //);
	$post['error'] = $error;
	$post['id_cat'] = $app['db']->lastInsertId();
	
    //$times = $app['db']->fetchAll('select * from feed_');
	//return $app->json($times);
    return $app->json($post);
});


// API : get a specific cat
$app->get('/cat/{id}', function($id) use ($app) {
    $cats = $app['db']->fetchAll('select c.*, d.id_dispenser, u.id_user, group_concat(concat(f.id_feedtime,\'||\',f.time,\'||\',f.weight,\'||\',f.enabled)) feed_times from cat c left join cat_dispenser cd using(id_cat) left join dispenser d using(id_dispenser) left join user u using(id_user) left join feed_times f using(id_cat) where c.id_cat = \''.$id.'\'');
	$feedtimes = explode(',',$cats[0]['feed_times']);
	$cats[0]['feed_times'] = array();
	foreach($feedtimes as $k => $v) {
		$feedtime = explode('||',$v);
		$cats[0]['feed_times'][] = array('id_feedtime' => $feedtime[0], 'time' => $feedtime[1], 'weight' => $feedtime[2], 'enabled' => $feedtime[3]);
	}
	return $app->json($cats);
})->bind('api_cat');

// API : get cats by user ID
$app->get('/cat/user/{id}', function($id) use ($app) {
	
	$res = $app['db']->fetchAll('select id_user from user u where u.id_user = \''.$id.'\'');
	if(count($res) == 0)
	{
		$data['error'] = 1;
	}
	else
	{	
		$cats = $app['db']->fetchAll('select c.* from cat c join cat_dispenser cd using(id_cat) join dispenser d using(id_dispenser) join user u using(id_user) where u.id_user = \''.$id.'\'');
		
		$data['error'] = 0;
		$data['cats'] = $cats;
	}
	
	return $app->json($data);
})->bind('api_cats_by_user');

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
?>